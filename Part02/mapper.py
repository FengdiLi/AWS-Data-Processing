#!/usr/bin/env python
#
# This file has been provided as a starting point. You need to modify this file.
# Reads whole lines stdin; writes key/value pairs to stdout
# --- DO NOT MODIFY ANYTHING ABOVE THIS LINE ---

import sys

if __name__ == "__main__":
        months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
        for line in sys.stdin:
                for word in line.split():
                        if (word.find('[') == 0 and word.find(':') == 12):
                                m = months.index(word[4:7])+1
                                y = word[8:12]
                                sys.stdout.write("{}-{:02d}\t1\n".format(y,m))
