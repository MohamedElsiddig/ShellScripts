# Download Folder Watcher

This script is used to manage the ~/Download folder of a user. It will be the
handler of inotify notifications and will move a downloaded file into
subfolders under the ~/Download folder named after the file's extension.

## Dependencies
- [wendy](https://github.com/z3bra/wendy)
- [at](https://linux.die.net/man/1/at)
- [GNU core utilities](https://www.gnu.org/software/coreutils/coreutils.html)


