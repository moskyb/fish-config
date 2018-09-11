# Mosky's Pretty Okay Fish Config

I use a lot of shell shortcuts in my every day life. Contained within this repo
are all the ones I use one a regular basis.

## Installation

To use this repo, you'll need to be using [Fish Shell](https://fishshell.com/),
which, fair warning, ~~can be~~ is almost certainly more effort than it's worth. Once you've got Fish
installed, run this block:

```Bash
cd ~./.config/fish
rm config.fish
git clone git@github.com:moskyb/fish-config.git
```

Then restart your terminal and you should be good

## Fair warning
The shell shortcuts within contain a whole bunch of dependencies that aren't listed
anywhere and it's likely that on installation, fish will complain about stuff not
being installed or configured properly. At some point I'll collate the dependencies into one file and
have something that installs all of them (`#TODO`), but at current the best solution
is to just delete the functions that you aren't likely to use.

Feel free to use, remix and distribute this in accordance with the MIT License - get amongst it!

<3
