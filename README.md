Customizing things down to the source code is incredibly empowering, and it's a shame that other distributions introduce a heavy maintainance cost when you try to do any of that, to the point you're sometimes better off just forking the distro.

This repository has been published to help substantiate this argument. Gentoo is, ironically enough, the easiest distribution for me to use. Nothing else comes close.

If you're snooping around, or I sent you here, I recommend checking out the `patches/` and `env/` directories, as these are where the *real* power resides. If you've heard Gentoo is powerful because of USE flags, that's really only scratching the surface.

Most everything else is bespoke portage configuration, where I try to work around some defaults and other things I don't particularly like.

NOTE: I've begun moving my configurations into custom profiles in `make.profile/`. Separating things out like this allows me to keep device- and setup-specific configurations in the same repository, only modifying the `make.profile/parent` file. Unfortunately, since make.profile is considered the "base" from which the rest of the portage configuration derives, I will have to move settings into there. I don't know if I'll ever finish moving everything.

DISCLAIMER: None of the settings expressed in this repository are necessarily things I endorse. I play with fire, and while things end up working out fine for me, I wouldn't want other people to burn themselves doing things these settings weren't equipped to handle. Please do your own research and understand the changes you're making to your own system.
