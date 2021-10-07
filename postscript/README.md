- http://paulbourke.net/dataformats/postscript/
- https://github.com/when/postscript/tree/master/ref
- https://personal.math.ubc.ca/~cass/graphics/manual/

- https://ia802600.us.archive.org/5/items/pdfy-1U9Ry1_Qj0LPSR6e/monterey86.pdf
- http://logand.com/sw/wps/

---

```
James W. Adams
unread,
Oct 21, 1998, 3:00:00 AM
to

Since some recent posters have speculated about "Sun's original window
system" as shipped in 4.1.1 and how this might or might not allow
remote X display, I thought I'd post a brief explanation. This is
not intended to be a historically authoritative summary.
Sun's early window system, SunView, was indeed local to the workstation,
and its programming interface became something of a de facto standard
for science/engineering applications.

Realizing that networks were becoming increasingly important, Sun
developed a followon based on James Gosling's work which was initially
called SunDEW, but later changed to NeWS (Network/extensible Window
System). You may recognize Gosling as the true father of the EMACS
text editor.

This is a prime example, IMHO, of the UNIX community stepping on its
own crank, as it were, without the help of Microsoft.

By the late 1980s, Sun's NFS had become the de facto standard for
distributed filesystems.

IBM, HP and DEC, among others, were bound and determined that this
recent upstart was not going to establish another such victory.

MIT had long before developed the Athena project as a networked
computing environment for student/academic use. This employed a
networked window system called X which relied on transmission of
bitmaps. Given the relatively primitive state of computer graphics
at the time, and the limited application of this protocol, this
seemed reasonable.

Sun enlisted Gosling and others to design a followon product for
SunView which would work over a network. The SPARC design project
was underway, and graphics were becoming increasingly important
in computing.

Gosling's solution was extremely elegant. He decided to use
Postscript, a (then) newly developed page description language
as the basic communications medium for the entire window system.
Instead of transmitting raw bitmaps over the network, objects were
encoded in Postscript and that was sent to the window server.

It is amusing to note that NeWS 1.0 on a Sun 3/60 ran about as fast
as X11R6 does on a 300 MHz Ultra.

Under NeWS, one could display a Postscript page by simply cat'ing the
file to the window server. SGI also adoped NeWS for their highend
graphics systems. Sun's first X server was actually written in the
NeWS enhanced Postscript language, and running on a Sun-3 actually
blew away every then-existing X implementation, even on superior
hardware.

Unfortunately, IBM, HP and DEC decided to throw enormous amounts of
money at MIT to develop Athena into a marketable, general-purpose
window system to compete with NeWS.

So, now we're stuck with X, arguably the most stupid networked
window system ever designed.

MBA students may want to use this as a case study.

Anyway, the SunOS 4.1.1 XNeWS server is capable of remote display,
but it is based on a very broken version of X11R3/4 and won't work
with Motif applications or many X11R4/5/6 apps.

This is an object lesson that technological superiority is easily
defeated by myopic marketing.
```
