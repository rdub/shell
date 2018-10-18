#!/usr/bin/env python
from datetime import date
d0 = date(2018, 10, 8)
d1 = date.today()

delta = d1 - d0
print delta.days + 1
