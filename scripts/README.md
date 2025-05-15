These are some scripts that aid me in keeping my system sane. I probably won't
be documenting them most of the time, but when people have questions I will try
to add the info here.

update scripts
--------------

The `update`, `upgrade` and `summary` scripts are meant to be used together. I tend to update only once a month, and I scrutinize every proposed change to my system.

* `update` checks if the ebuilds have been synced within the last month, and creates a report of the available updates in /var/spool/updates/pending
* `summary` highlights the important bits of the available updates, which is useful when the report is huge, as it sometimes is when I hold off on updates for a few months.
* `upgrade` then accepts and executes the upgrade. It makes sure baselayout, portage, and compilers are upgraded first, and then applies the remaining upgrades.
