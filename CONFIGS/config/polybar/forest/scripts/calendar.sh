#!/usr/bin/env python3
import calendar as cal
import tkinter as tk
from datetime import date, timedelta
import subprocess
import os
import signal
import sys

PID_FILE = "/tmp/polybar-calendar.pid"

# Toggle: if already open, kill it and exit
if os.path.exists(PID_FILE):
    try:
        with open(PID_FILE) as f:
            old_pid = int(f.read().strip())
        os.kill(old_pid, signal.SIGKILL)
    except (ProcessLookupError, ValueError, OSError):
        pass
    os.unlink(PID_FILE)
    sys.exit(0)

# Write PID
with open(PID_FILE, "w") as f:
    f.write(str(os.getpid()))

# Colombian holidays
def colombian_holidays(year):
    h = {}

    def add_if(m, d, name):
        h[(m, d)] = name

    def easter_sunday(y):
        a = y % 19
        b = y // 100
        c = y % 100
        d = b // 4
        e = b % 4
        f = (b + 8) // 25
        g = (b - f + 1) // 3
        h_ = (19 * a + b - d - g + 15) % 30
        i = c // 4
        k = c % 4
        l_ = (32 + 2 * e + 2 * i - h_ - k) % 7
        m_ = (a + 11 * h_ + 22 * l_) // 451
        month = (h_ + l_ - 7 * m_ + 114) // 31
        day = ((h_ + l_ - 7 * m_ + 114) % 31) + 1
        return date(y, month, day)

    def next_monday(d):
        return d + timedelta(days=(7 - d.weekday()) % 7)

    def easter_offset(y, days):
        return next_monday(easter_sunday(y) + timedelta(days=days))

    es = easter_sunday(year)

    add_if(1, 1, "Año Nuevo")
    add_if(5, 1, "Día del Trabajo")
    add_if(7, 20, "Independencia")
    add_if(8, 7, "Batalla de Boyacá")
    add_if(12, 8, "Inmaculada Concepción")
    add_if(12, 25, "Navidad")

    epiphany = next_monday(date(year, 1, 6))
    add_if(epiphany.month, epiphany.day, "Reyes Magos")

    st_joseph = next_monday(date(year, 3, 19))
    add_if(st_joseph.month, st_joseph.day, "San José")

    maundy = es - timedelta(days=3)
    add_if(maundy.month, maundy.day, "Jueves Santo")

    good_friday = es - timedelta(days=2)
    add_if(good_friday.month, good_friday.day, "Viernes Santo")

    ascension = easter_offset(year, 43)
    add_if(ascension.month, ascension.day, "Ascensión")

    corpus_christi = easter_offset(year, 64)
    add_if(corpus_christi.month, corpus_christi.day, "Corpus Christi")

    sacred_heart = easter_offset(year, 71)
    add_if(sacred_heart.month, sacred_heart.day, "Sagrado Corazón")

    st_peter = next_monday(date(year, 6, 29))
    add_if(st_peter.month, st_peter.day, "San Pedro")

    assumption = next_monday(date(year, 8, 15))
    add_if(assumption.month, assumption.day, "Asunción")

    race_day = next_monday(date(year, 10, 12))
    add_if(race_day.month, race_day.day, "Día de la Raza")

    all_saints = next_monday(date(year, 11, 1))
    add_if(all_saints.month, all_saints.day, "Todos los Santos")

    independence_cartagena = next_monday(date(year, 11, 11))
    add_if(independence_cartagena.month, independence_cartagena.day, "Ind. Cartagena")

    return h


def get_polybar_position():
    try:
        pid = subprocess.check_output(["pgrep", "polybar"], text=True).strip().split("\n")[0]
        wid = subprocess.check_output(["xdotool", "search", "--pid", pid], text=True).strip().split("\n")[0]
        geo = subprocess.check_output(["xdotool", "getwindowgeometry", wid], text=True)
        px, py, pw, ph = 0, 0, 1920, 48
        for line in geo.split("\n"):
            line = line.strip()
            if line.startswith("Position:"):
                parts = line.split()
                px = int(parts[1].split(",")[0])
                py = int(parts[1].split(",")[1])
            elif line.startswith("Geometry:"):
                parts = line.split()
                pw = int(parts[1].split("x")[0])
                ph = int(parts[1].split("x")[1])
        # Place below polybar, right-aligned (calendar ~320px wide)
        return px + pw - 330, py + ph
    except Exception:
        pass
    try:
        geo = subprocess.check_output(["xdotool", "getdisplaygeometry"], text=True)
        parts = geo.strip().split()
        return int(parts[0]) - 330, 50
    except Exception:
        return 100, 50


class CalendarPopup:
    def __init__(self):
        self.today = date.today()
        self.year = self.today.year
        self.month = self.today.month
        self.holidays = colombian_holidays(self.year)

        self.root = tk.Tk()
        self.root.title("")
        self.root.overrideredirect(True)
        self.root.attributes("-topmost", True)
        self.root.configure(bg="#282c34")

        self.root.bind("<Escape>", lambda e: self.cleanup())

        self.build_ui()
        self.update_calendar()

        wx, wy = get_polybar_position()
        if wx is not None:
            self.root.geometry(f"+{wx}+{wy}")
        else:
            self.root.geometry("+100+100")

        self.root.attributes("-type", "popup-menu")
        self.root.focus_force()
        self.root.mainloop()

    def cleanup(self):
        try:
            if os.path.exists(PID_FILE):
                os.unlink(PID_FILE)
            self.root.destroy()
        except tk.TclError:
            pass

    def build_ui(self):
        nav = tk.Frame(self.root, bg="#282c34")
        nav.pack(pady=(6, 2))

        tk.Button(nav, text="◀", command=self.prev_month,
                  bg="#3b4049", fg="#abb2bf", relief=tk.FLAT,
                  font=("Hack Nerd Font", 10), cursor="hand2",
                  takefocus=0,
                  activebackground="#98c379", activeforeground="#282c34")\
            .pack(side=tk.LEFT, padx=(0, 8))

        self.month_label = tk.Label(nav, font=("Hack Nerd Font", 11, "bold"),
                                    bg="#282c34", fg="#e5c07b")
        self.month_label.pack(side=tk.LEFT, padx=10)

        tk.Button(nav, text="▶", command=self.next_month,
                  bg="#3b4049", fg="#abb2bf", relief=tk.FLAT,
                  font=("Hack Nerd Font", 10), cursor="hand2",
                  takefocus=0,
                  activebackground="#98c379", activeforeground="#282c34")\
            .pack(side=tk.LEFT, padx=(8, 0))

        self.cal_frame = tk.Frame(self.root, bg="#282c34")
        self.cal_frame.pack(pady=(4, 4), padx=8)

        self.holiday_label = tk.Label(self.root, text="",
                                      font=("Hack Nerd Font", 9),
                                      bg="#282c34", fg="#61afef",
                                      wraplength=280, justify=tk.CENTER)
        self.holiday_label.pack(pady=(0, 4))

    def update_calendar(self):
        for w in self.cal_frame.winfo_children():
            w.destroy()

        self.month_label.config(text=f"{cal.month_name[self.month]} {self.year}")

        for i, day in enumerate(["Lu", "Ma", "Mi", "Ju", "Vi", "Sa", "Do"]):
            color = "#e06c75" if i >= 5 else "#abb2bf"
            tk.Label(self.cal_frame, text=day,
                     font=("Hack Nerd Font", 9, "bold"),
                     bg="#282c34", fg=color, width=3)\
                .grid(row=0, column=i, padx=1, pady=2)

        mc = cal.monthcalendar(self.year, self.month)
        for r, week in enumerate(mc):
            for c, day in enumerate(week):
                if day == 0:
                    tk.Label(self.cal_frame, text="",
                             bg="#282c34", width=3)\
                        .grid(row=r + 1, column=c, padx=1, pady=1)
                    continue

                is_holiday = (self.month, day) in self.holidays
                is_today = (self.year, self.month, day) == (self.today.year, self.today.month, self.today.day)
                is_weekend = c >= 5

                if is_holiday:
                    fg = "#e06c75"
                    bg = "#3b4049"
                elif is_today:
                    fg = "#282c34"
                    bg = "#98c379"
                elif is_weekend:
                    fg = "#5c6370"
                    bg = "#282c34"
                else:
                    fg = "#abb2bf"
                    bg = "#282c34"

                btn = tk.Label(self.cal_frame, text=str(day),
                               font=("Hack Nerd Font", 10),
                               bg=bg, fg=fg, width=3, cursor="hand2")
                btn.grid(row=r + 1, column=c, padx=1, pady=1)

                if is_holiday:
                    holiday_name = self.holidays[(self.month, day)]
                    btn.bind("<Enter>", lambda e, n=holiday_name:
                             self.holiday_label.config(text=f"🎉 {n}"))
                    btn.bind("<Leave>", lambda e:
                             self.holiday_label.config(text=""))

    def prev_month(self):
        if self.month == 1:
            self.month = 12
            self.year -= 1
        else:
            self.month -= 1
        self.holidays = colombian_holidays(self.year)
        self.update_calendar()

    def next_month(self):
        if self.month == 12:
            self.month = 1
            self.year += 1
        else:
            self.month += 1
        self.holidays = colombian_holidays(self.year)
        self.update_calendar()


if __name__ == "__main__":
    try:
        CalendarPopup()
    finally:
        if os.path.exists(PID_FILE):
            os.unlink(PID_FILE)
