# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

from system import string, quit, QUIT_SUCCESS, QUIT_FAILURE

proc success* =
  quit(QUIT_SUCCESS)

proc success_msg*(output: string) =
  quit(output, QUIT_SUCCESS)

proc failure* =
  quit(QUIT_FAILURE)

proc failure_msg*(output: string) =
  quit(output, QUIT_FAILURE)
