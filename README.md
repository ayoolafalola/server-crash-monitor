# Server Crash Monitor

Run this script to reboot your server whenever it is at the verge of crashing. This little script has helped me to keep a lot of my high-load servers up. Whenever servers get too much load, they may just turn into a zombie and not be able to serve any process anymore. This script detects this status and reboots the server so as to begin work afresh. This script will then send an email to the admin with relevant information to use to debug the issue.

# Usage

Change `hostmaster@example.com` to your email address to get notification whenever your server is rebooted.

Run `install.sh`. You can also copy and paste its content to the terminal. Has to be run as root to work. This script has been tested to work on Ubuntu Servers, it may as well work on other servers but that hasn't been verified yet.
