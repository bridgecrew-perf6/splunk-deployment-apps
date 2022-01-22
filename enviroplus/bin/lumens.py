#!/usr/bin/env python3

import time
try:
    # Transitional fix for breaking change in LTR559
    from ltr559 import LTR559
    ltr559 = LTR559()
except ImportError:
    import ltr559


## Take a pointless reading as the first output is always zero for some reason
lux = ltr559.get_lux()
## must sleep before the second reading is taken
time.sleep(0.1)

## Actual reading for measurement
lux = ltr559.get_lux()
lux = int(lux)
print(lux)
