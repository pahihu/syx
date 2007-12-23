#include <X11/Xlib.h>
#include <X11/X.h>
#include <X11/Xlcint.h>
#include <X11/Xproto.h>
#include <X11/Xprotostr.h>
#include <X11/Xfuncproto.h>

%include typemaps.i
%include cpointer.i

typedef void * XConnectionWatchProc;
typedef void * XErrorHandler;
typedef void * XIMProc;
typedef void * XIOErrorHandler;
typedef void * XVaNestedList;
typedef void * XPointer;

%apply int {
    Status, Window ,Time, Cursor,
    XID, Drawable, Font, Pixmap,
    Colormap, GContext, KeySym, Mask,
    Atom, VisualID, KeyCode
}

%include Xlib_structs.i

%module Xlib
%{

extern XFontStruct *XLoadQueryFont(
    Display*		/* display */,
    const char*	/* name */
);

extern XFontStruct *XQueryFont(
    Display*		/* display */,
    XID			/* font_ID */
);


extern XTimeCoord *XGetMotionEvents(
    Display*		/* display */,
    Window		/* w */,
    Time		/* start */,
    Time		/* stop */,
    int*		/* nevents_return */
);

extern XModifierKeymap *XDeleteModifiermapEntry(
    XModifierKeymap*	/* modmap */,
    KeyCode		/* keycode_entry */,
    int			/* modifier */
);

extern XModifierKeymap	*XGetModifierMapping(
    Display*		/* display */
);

extern XModifierKeymap	*XInsertModifiermapEntry(
    XModifierKeymap*	/* modmap */,
    KeyCode		/* keycode_entry */,
    int			/* modifier */    
);

extern XModifierKeymap *XNewModifiermap(
    int			/* max_keys_per_mod */
);

extern XImage *XCreateImage(
    Display*		/* display */,
    Visual*		/* visual */,
    unsigned int	/* depth */,
    int			/* format */,
    int			/* offset */,
    char*		/* data */,
    unsigned int	/* width */,
    unsigned int	/* height */,
    int			/* bitmap_pad */,
    int			/* bytes_per_line */
);
extern Status XInitImage(
    XImage*		/* image */
);
extern XImage *XGetImage(
    Display*		/* display */,
    Drawable		/* d */,
    int			/* x */,
    int			/* y */,
    unsigned int	/* width */,
    unsigned int	/* height */,
    unsigned long	/* plane_mask */,
    int			/* format */
);
extern XImage *XGetSubImage(
    Display*		/* display */,
    Drawable		/* d */,
    int			/* x */,
    int			/* y */,
    unsigned int	/* width */,
    unsigned int	/* height */,
    unsigned long	/* plane_mask */,
    int			/* format */,
    XImage*		/* dest_image */,
    int			/* dest_x */,
    int			/* dest_y */
);

/* 
 * X function declarations.
 */
extern Display *XOpenDisplay(
    const char*	/* display_name */
);

extern void XrmInitialize(
    void
);

extern char *XFetchBytes(
    Display*		/* display */,
    int*		/* nbytes_return */
);
extern char *XFetchBuffer(
    Display*		/* display */,
    int*		/* nbytes_return */,
    int			/* buffer */
);
extern char *XGetAtomName(
    Display*		/* display */,
    Atom		/* atom */
);
extern Status XGetAtomNames(
    Display*		/* dpy */,
    Atom*		/* atoms */,
    int			/* count */,
    char**		/* names_return */
);
extern char *XGetDefault(
    Display*		/* display */,
    const char*	/* program */,
    const char*	/* option */		  
);
extern char *XDisplayName(
    const char*	/* string */
);
extern char *XKeysymToString(
    KeySym		/* keysym */
);

extern int (*XSynchronize(
    Display*		/* display */,
    Bool		/* onoff */
))(
    Display*		/* display */
);
extern int (*XSetAfterFunction(
    Display*		/* display */,
    int (*) (
	     Display*	/* display */
            )		/* procedure */
))(
    Display*		/* display */
);
extern Atom XInternAtom(
    Display*		/* display */,
    const char*	/* atom_name */,
    Bool		/* only_if_exists */		 
);
extern Status XInternAtoms(
    Display*		/* dpy */,
    char**		/* names */,
    int			/* count */,
    Bool		/* onlyIfExists */,
    Atom*		/* atoms_return */
);
extern Colormap XCopyColormapAndFree(
    Display*		/* display */,
    Colormap		/* colormap */
);
extern Colormap XCreateColormap(
    Display*		/* display */,
    Window		/* w */,
    Visual*		/* visual */,
    int			/* alloc */			 
);
extern Cursor XCreatePixmapCursor(
    Display*		/* display */,
    Pixmap		/* source */,
    Pixmap		/* mask */,
    XColor*		/* foreground_color */,
    XColor*		/* background_color */,
    unsigned int	/* x */,
    unsigned int	/* y */			   
);
extern Cursor XCreateGlyphCursor(
    Display*		/* display */,
    Font		/* source_font */,
    Font		/* mask_font */,
    unsigned int	/* source_char */,
    unsigned int	/* mask_char */,
    XColor const *	/* foreground_color */,
    XColor const *	/* background_color */
);
extern Cursor XCreateFontCursor(
    Display*		/* display */,
    unsigned int	/* shape */
);
extern Font XLoadFont(
    Display*		/* display */,
    const char*	/* name */
);
extern GC XCreateGC(
    Display*		/* display */,
    Drawable		/* d */,
    unsigned long	/* valuemask */,
    XGCValues*		/* values */
);
extern GContext XGContextFromGC(
    GC			/* gc */
);
extern void XFlushGC(
    Display*		/* display */,
    GC			/* gc */
);
extern Pixmap XCreatePixmap(
    Display*		/* display */,
    Drawable		/* d */,
    unsigned int	/* width */,
    unsigned int	/* height */,
    unsigned int	/* depth */		        
);
extern Pixmap XCreateBitmapFromData(
    Display*		/* display */,
    Drawable		/* d */,
    const char*	/* data */,
    unsigned int	/* width */,
    unsigned int	/* height */
);
extern Pixmap XCreatePixmapFromBitmapData(
    Display*		/* display */,
    Drawable		/* d */,
    char*		/* data */,
    unsigned int	/* width */,
    unsigned int	/* height */,
    unsigned long	/* fg */,
    unsigned long	/* bg */,
    unsigned int	/* depth */
);
extern Window XCreateSimpleWindow(
    Display*		/* display */,
    Window		/* parent */,
    int			/* x */,
    int			/* y */,
    unsigned int	/* width */,
    unsigned int	/* height */,
    unsigned int	/* border_width */,
    unsigned long	/* border */,
    unsigned long	/* background */
);
extern Window XGetSelectionOwner(
    Display*		/* display */,
    Atom		/* selection */
);
extern Window XCreateWindow(
    Display*		/* display */,
    Window		/* parent */,
    int			/* x */,
    int			/* y */,
    unsigned int	/* width */,
    unsigned int	/* height */,
    unsigned int	/* border_width */,
    int			/* depth */,
    unsigned int	/* class */,
    Visual*		/* visual */,
    unsigned long	/* valuemask */,
    XSetWindowAttributes*	/* attributes */
); 
extern Colormap *XListInstalledColormaps(
    Display*		/* display */,
    Window		/* w */,
    int*		/* num_return */
);
extern char **XListFonts(
    Display*		/* display */,
    const char*	/* pattern */,
    int			/* maxnames */,
    int*		/* actual_count_return */
);
extern char **XListFontsWithInfo(
    Display*		/* display */,
    const char*	/* pattern */,
    int			/* maxnames */,
    int*		/* count_return */,
    XFontStruct**	/* info_return */
);
extern char **XGetFontPath(
    Display*		/* display */,
    int*		/* npaths_return */
);
extern char **XListExtensions(
    Display*		/* display */,
    int*		/* nextensions_return */
);
extern Atom *XListProperties(
    Display*		/* display */,
    Window		/* w */,
    int*		/* num_prop_return */
);
extern XHostAddress *XListHosts(
    Display*		/* display */,
    int*		/* nhosts_return */,
    Bool*		/* state_return */
);
extern KeySym XKeycodeToKeysym(
    Display*		/* display */,
    KeyCode		/* keycode */,
    int			/* index */
);
extern KeySym XLookupKeysym(
    XKeyEvent*		/* key_event */,
    int			/* index */
);
extern KeySym *XGetKeyboardMapping(
    Display*		/* display */,
    KeyCode		/* first_keycode */,
    int			/* keycode_count */,
    int*		/* keysyms_per_keycode_return */
);
extern KeySym XStringToKeysym(
    const char*	/* string */
);
extern long XMaxRequestSize(
    Display*		/* display */
);
extern long XExtendedMaxRequestSize(
    Display*		/* display */
);
extern char *XResourceManagerString(
    Display*		/* display */
);
extern char *XScreenResourceString(
	Screen*		/* screen */
);
extern unsigned long XDisplayMotionBufferSize(
    Display*		/* display */
);
extern VisualID XVisualIDFromVisual(
    Visual*		/* visual */
);

/* multithread routines */

extern Status XInitThreads(
    void
);

extern void XLockDisplay(
    Display*		/* display */
);

extern void XUnlockDisplay(
    Display*		/* display */
);

/* routines for dealing with extensions */

extern XExtCodes *XInitExtension(
    Display*		/* display */,
    const char*	/* name */
);

extern XExtCodes *XAddExtension(
    Display*		/* display */
);
extern XExtData *XFindOnExtensionList(
    XExtData**		/* structure */,
    int			/* number */
);

/* these are routines for which there are also macros */
extern Window XRootWindow(
    Display*		/* display */,
    int			/* screen_number */
);
extern Window XDefaultRootWindow(
    Display*		/* display */
);
extern Window XRootWindowOfScreen(
    Screen*		/* screen */
);
extern Visual *XDefaultVisual(
    Display*		/* display */,
    int			/* screen_number */
);
extern Visual *XDefaultVisualOfScreen(
    Screen*		/* screen */
);
extern GC XDefaultGC(
    Display*		/* display */,
    int			/* screen_number */
);
extern GC XDefaultGCOfScreen(
    Screen*		/* screen */
);
extern unsigned long XBlackPixel(
    Display*		/* display */,
    int			/* screen_number */
);
extern unsigned long XWhitePixel(
    Display*		/* display */,
    int			/* screen_number */
);
extern unsigned long XAllPlanes(
    void
);
extern unsigned long XBlackPixelOfScreen(
    Screen*		/* screen */
);
extern unsigned long XWhitePixelOfScreen(
    Screen*		/* screen */
);
extern unsigned long XNextRequest(
    Display*		/* display */
);
extern unsigned long XLastKnownRequestProcessed(
    Display*		/* display */
);
extern char *XServerVendor(
    Display*		/* display */
);
extern char *XDisplayString(
    Display*		/* display */
);
extern Colormap XDefaultColormap(
    Display*		/* display */,
    int			/* screen_number */
);
extern Colormap XDefaultColormapOfScreen(
    Screen*		/* screen */
);
extern Display *XDisplayOfScreen(
    Screen*		/* screen */
);
extern Screen *XScreenOfDisplay(
    Display*		/* display */,
    int			/* screen_number */
);
extern Screen *XDefaultScreenOfDisplay(
    Display*		/* display */
);
extern long XEventMaskOfScreen(
    Screen*		/* screen */
);

extern int XScreenNumberOfScreen(
    Screen*		/* screen */
);

extern XErrorHandler XSetErrorHandler (
    XErrorHandler	/* handler */
);


extern XIOErrorHandler XSetIOErrorHandler (
    XIOErrorHandler	/* handler */
);


extern XPixmapFormatValues *XListPixmapFormats(
    Display*		/* display */,
    int*		/* count_return */
);
extern int *XListDepths(
    Display*		/* display */,
    int			/* screen_number */,
    int*		/* count_return */
);

/* ICCCM routines for things that don't require special include files; */
/* other declarations are given in Xutil.h                             */
extern Status XReconfigureWMWindow(
    Display*		/* display */,
    Window		/* w */,
    int			/* screen_number */,
    unsigned int	/* mask */,
    XWindowChanges*	/* changes */
);

extern Status XGetWMProtocols(
    Display*		/* display */,
    Window		/* w */,
    Atom**		/* protocols_return */,
    int*		/* count_return */
);
extern Status XSetWMProtocols(
    Display*		/* display */,
    Window		/* w */,
    Atom*		/* protocols */,
    int			/* count */
);
extern Status XIconifyWindow(
    Display*		/* display */,
    Window		/* w */,
    int			/* screen_number */
);
extern Status XWithdrawWindow(
    Display*		/* display */,
    Window		/* w */,
    int			/* screen_number */
);
extern Status XGetCommand(
    Display*		/* display */,
    Window		/* w */,
    char***		/* argv_return */,
    int*		/* argc_return */
);
extern Status XGetWMColormapWindows(
    Display*		/* display */,
    Window		/* w */,
    Window**		/* windows_return */,
    int*		/* count_return */
);
extern Status XSetWMColormapWindows(
    Display*		/* display */,
    Window		/* w */,
    Window*		/* colormap_windows */,
    int			/* count */
);
extern void XFreeStringList(
    char**		/* list */
);
extern int XSetTransientForHint(
    Display*		/* display */,
    Window		/* w */,
    Window		/* prop_window */
);

/* The following are given in alphabetical order */

extern int XActivateScreenSaver(
    Display*		/* display */
);

extern int XAddHost(
    Display*		/* display */,
    XHostAddress*	/* host */
);

extern int XAddHosts(
    Display*		/* display */,
    XHostAddress*	/* hosts */,
    int			/* num_hosts */    
);

extern int XAddToExtensionList(
    struct _XExtData**	/* structure */,
    XExtData*		/* ext_data */
);

extern int XAddToSaveSet(
    Display*		/* display */,
    Window		/* w */
);

extern Status XAllocColor(
    Display*		/* display */,
    Colormap		/* colormap */,
    XColor*		/* screen_in_out */
);

extern Status XAllocColorCells(
    Display*		/* display */,
    Colormap		/* colormap */,
    Bool	        /* contig */,
    unsigned long*	/* plane_masks_return */,
    unsigned int	/* nplanes */,
    unsigned long*	/* pixels_return */,
    unsigned int 	/* npixels */
);

extern Status XAllocColorPlanes(
    Display*		/* display */,
    Colormap		/* colormap */,
    Bool		/* contig */,
    unsigned long*	/* pixels_return */,
    int			/* ncolors */,
    int			/* nreds */,
    int			/* ngreens */,
    int			/* nblues */,
    unsigned long*	/* rmask_return */,
    unsigned long*	/* gmask_return */,
    unsigned long*	/* bmask_return */
);

extern Status XAllocNamedColor(
    Display*		/* display */,
    Colormap		/* colormap */,
    const char*	/* color_name */,
    XColor*		/* screen_def_return */,
    XColor*		/* exact_def_return */
);

extern int XAllowEvents(
    Display*		/* display */,
    int			/* event_mode */,
    Time		/* time */
);

extern int XAutoRepeatOff(
    Display*		/* display */
);

extern int XAutoRepeatOn(
    Display*		/* display */
);

extern int XBell(
    Display*		/* display */,
    int			/* percent */
);

extern int XBitmapBitOrder(
    Display*		/* display */
);

extern int XBitmapPad(
    Display*		/* display */
);

extern int XBitmapUnit(
    Display*		/* display */
);

extern int XCellsOfScreen(
    Screen*		/* screen */
);

extern int XChangeActivePointerGrab(
    Display*		/* display */,
    unsigned int	/* event_mask */,
    Cursor		/* cursor */,
    Time		/* time */
);

extern int XChangeGC(
    Display*		/* display */,
    GC			/* gc */,
    unsigned long	/* valuemask */,
    XGCValues*		/* values */
);

extern int XChangeKeyboardControl(
    Display*		/* display */,
    unsigned long	/* value_mask */,
    XKeyboardControl*	/* values */
);

extern int XChangeKeyboardMapping(
    Display*		/* display */,
    int			/* first_keycode */,
    int			/* keysyms_per_keycode */,
    KeySym*		/* keysyms */,
    int			/* num_codes */
);

extern int XChangePointerControl(
    Display*		/* display */,
    Bool		/* do_accel */,
    Bool		/* do_threshold */,
    int			/* accel_numerator */,
    int			/* accel_denominator */,
    int			/* threshold */
);

extern int XChangeProperty(
    Display*		/* display */,
    Window		/* w */,
    Atom		/* property */,
    Atom		/* type */,
    int			/* format */,
    int			/* mode */,
    const unsigned char*	/* data */,
    int			/* nelements */
);

extern int XChangeSaveSet(
    Display*		/* display */,
    Window		/* w */,
    int			/* change_mode */
);

extern int XChangeWindowAttributes(
    Display*		/* display */,
    Window		/* w */,
    unsigned long	/* valuemask */,
    XSetWindowAttributes* /* attributes */
);

extern Bool XCheckIfEvent(
    Display*		/* display */,
    XEvent*		/* event_return */,
    Bool (*) (
	       Display*			/* display */,
               XEvent*			/* event */,
               XPointer			/* arg */
             )		/* predicate */,
    XPointer		/* arg */
);

extern Bool XCheckMaskEvent(
    Display*		/* display */,
    long		/* event_mask */,
    XEvent*		/* event_return */
);

extern Bool XCheckTypedEvent(
    Display*		/* display */,
    int			/* event_type */,
    XEvent*		/* event_return */
);

extern Bool XCheckTypedWindowEvent(
    Display*		/* display */,
    Window		/* w */,
    int			/* event_type */,
    XEvent*		/* event_return */
);

extern Bool XCheckWindowEvent(
    Display*		/* display */,
    Window		/* w */,
    long		/* event_mask */,
    XEvent*		/* event_return */
);

extern int XCirculateSubwindows(
    Display*		/* display */,
    Window		/* w */,
    int			/* direction */
);

extern int XCirculateSubwindowsDown(
    Display*		/* display */,
    Window		/* w */
);

extern int XCirculateSubwindowsUp(
    Display*		/* display */,
    Window		/* w */
);

extern int XClearArea(
    Display*		/* display */,
    Window		/* w */,
    int			/* x */,
    int			/* y */,
    unsigned int	/* width */,
    unsigned int	/* height */,
    Bool		/* exposures */
);

extern int XClearWindow(
    Display*		/* display */,
    Window		/* w */
);

extern int XCloseDisplay(
    Display*		/* display */
);

extern int XConfigureWindow(
    Display*		/* display */,
    Window		/* w */,
    unsigned int	/* value_mask */,
    XWindowChanges*	/* values */		 
);

extern int XConnectionNumber(
    Display*		/* display */
);

extern int XConvertSelection(
    Display*		/* display */,
    Atom		/* selection */,
    Atom 		/* target */,
    Atom		/* property */,
    Window		/* requestor */,
    Time		/* time */
);

extern int XCopyArea(
    Display*		/* display */,
    Drawable		/* src */,
    Drawable		/* dest */,
    GC			/* gc */,
    int			/* src_x */,
    int			/* src_y */,
    unsigned int	/* width */,
    unsigned int	/* height */,
    int			/* dest_x */,
    int			/* dest_y */
);

extern int XCopyGC(
    Display*		/* display */,
    GC			/* src */,
    unsigned long	/* valuemask */,
    GC			/* dest */
);

extern int XCopyPlane(
    Display*		/* display */,
    Drawable		/* src */,
    Drawable		/* dest */,
    GC			/* gc */,
    int			/* src_x */,
    int			/* src_y */,
    unsigned int	/* width */,
    unsigned int	/* height */,
    int			/* dest_x */,
    int			/* dest_y */,
    unsigned long	/* plane */
);

extern int XDefaultDepth(
    Display*		/* display */,
    int			/* screen_number */
);

extern int XDefaultDepthOfScreen(
    Screen*		/* screen */
);

extern int XDefaultScreen(
    Display*		/* display */
);

extern int XDefineCursor(
    Display*		/* display */,
    Window		/* w */,
    Cursor		/* cursor */
);

extern int XDeleteProperty(
    Display*		/* display */,
    Window		/* w */,
    Atom		/* property */
);

extern int XDestroyWindow(
    Display*		/* display */,
    Window		/* w */
);

extern int XDestroySubwindows(
    Display*		/* display */,
    Window		/* w */
);

extern int XDoesBackingStore(
    Screen*		/* screen */    
);

extern Bool XDoesSaveUnders(
    Screen*		/* screen */
);

extern int XDisableAccessControl(
    Display*		/* display */
);


extern int XDisplayCells(
    Display*		/* display */,
    int			/* screen_number */
);

extern int XDisplayHeight(
    Display*		/* display */,
    int			/* screen_number */
);

extern int XDisplayHeightMM(
    Display*		/* display */,
    int			/* screen_number */
);

extern int XDisplayKeycodes(
    Display*		/* display */,
    int*		/* min_keycodes_return */,
    int*		/* max_keycodes_return */
);

extern int XDisplayPlanes(
    Display*		/* display */,
    int			/* screen_number */
);

extern int XDisplayWidth(
    Display*		/* display */,
    int			/* screen_number */
);

extern int XDisplayWidthMM(
    Display*		/* display */,
    int			/* screen_number */
);

extern int XDrawArc(
    Display*		/* display */,
    Drawable		/* d */,
    GC			/* gc */,
    int			/* x */,
    int			/* y */,
    unsigned int	/* width */,
    unsigned int	/* height */,
    int			/* angle1 */,
    int			/* angle2 */
);

extern int XDrawArcs(
    Display*		/* display */,
    Drawable		/* d */,
    GC			/* gc */,
    XArc*		/* arcs */,
    int			/* narcs */
);

extern int XDrawImageString(
    Display*		/* display */,
    Drawable		/* d */,
    GC			/* gc */,
    int			/* x */,
    int			/* y */,
    const char*	/* string */,
    int			/* length */
);

extern int XDrawImageString16(
    Display*		/* display */,
    Drawable		/* d */,
    GC			/* gc */,
    int			/* x */,
    int			/* y */,
    const XChar2b*	/* string */,
    int			/* length */
);

extern int XDrawLine(
    Display*		/* display */,
    Drawable		/* d */,
    GC			/* gc */,
    int			/* x1 */,
    int			/* y1 */,
    int			/* x2 */,
    int			/* y2 */
);

extern int XDrawLines(
    Display*		/* display */,
    Drawable		/* d */,
    GC			/* gc */,
    XPoint*		/* points */,
    int			/* npoints */,
    int			/* mode */
);

extern int XDrawPoint(
    Display*		/* display */,
    Drawable		/* d */,
    GC			/* gc */,
    int			/* x */,
    int			/* y */
);

extern int XDrawPoints(
    Display*		/* display */,
    Drawable		/* d */,
    GC			/* gc */,
    XPoint*		/* points */,
    int			/* npoints */,
    int			/* mode */
);

extern int XDrawRectangle(
    Display*		/* display */,
    Drawable		/* d */,
    GC			/* gc */,
    int			/* x */,
    int			/* y */,
    unsigned int	/* width */,
    unsigned int	/* height */
);

extern int XDrawRectangles(
    Display*		/* display */,
    Drawable		/* d */,
    GC			/* gc */,
    XRectangle*		/* rectangles */,
    int			/* nrectangles */
);

extern int XDrawSegments(
    Display*		/* display */,
    Drawable		/* d */,
    GC			/* gc */,
    XSegment*		/* segments */,
    int			/* nsegments */
);

extern int XDrawString(
    Display*		/* display */,
    Drawable		/* d */,
    GC			/* gc */,
    int			/* x */,
    int			/* y */,
    const char*	/* string */,
    int			/* length */
);

extern int XDrawString16(
    Display*		/* display */,
    Drawable		/* d */,
    GC			/* gc */,
    int			/* x */,
    int			/* y */,
    const XChar2b*	/* string */,
    int			/* length */
);

extern int XDrawText(
    Display*		/* display */,
    Drawable		/* d */,
    GC			/* gc */,
    int			/* x */,
    int			/* y */,
    XTextItem*		/* items */,
    int			/* nitems */
);

extern int XDrawText16(
    Display*		/* display */,
    Drawable		/* d */,
    GC			/* gc */,
    int			/* x */,
    int			/* y */,
    XTextItem16*	/* items */,
    int			/* nitems */
);

extern int XEnableAccessControl(
    Display*		/* display */
);

extern int XEventsQueued(
    Display*		/* display */,
    int			/* mode */
);

extern Status XFetchName(
    Display*		/* display */,
    Window		/* w */,
    char**		/* window_name_return */
);

extern int XFillArc(
    Display*		/* display */,
    Drawable		/* d */,
    GC			/* gc */,
    int			/* x */,
    int			/* y */,
    unsigned int	/* width */,
    unsigned int	/* height */,
    int			/* angle1 */,
    int			/* angle2 */
);

extern int XFillArcs(
    Display*		/* display */,
    Drawable		/* d */,
    GC			/* gc */,
    XArc*		/* arcs */,
    int			/* narcs */
);

extern int XFillPolygon(
    Display*		/* display */,
    Drawable		/* d */,
    GC			/* gc */,
    XPoint*		/* points */,
    int			/* npoints */,
    int			/* shape */,
    int			/* mode */
);

extern int XFillRectangle(
    Display*		/* display */,
    Drawable		/* d */,
    GC			/* gc */,
    int			/* x */,
    int			/* y */,
    unsigned int	/* width */,
    unsigned int	/* height */
);

extern int XFillRectangles(
    Display*		/* display */,
    Drawable		/* d */,
    GC			/* gc */,
    XRectangle*		/* rectangles */,
    int			/* nrectangles */
);

extern int XFlush(
    Display*		/* display */
);

extern int XForceScreenSaver(
    Display*		/* display */,
    int			/* mode */
);

extern int XFree(
    void*		/* data */
);

extern int XFreeColormap(
    Display*		/* display */,
    Colormap		/* colormap */
);

extern int XFreeColors(
    Display*		/* display */,
    Colormap		/* colormap */,
    unsigned long*	/* pixels */,
    int			/* npixels */,
    unsigned long	/* planes */
);

extern int XFreeCursor(
    Display*		/* display */,
    Cursor		/* cursor */
);

extern int XFreeExtensionList(
    char**		/* list */    
);

extern int XFreeFont(
    Display*		/* display */,
    XFontStruct*	/* font_struct */
);

extern int XFreeFontInfo(
    char**		/* names */,
    XFontStruct*	/* free_info */,
    int			/* actual_count */
);

extern int XFreeFontNames(
    char**		/* list */
);

extern int XFreeFontPath(
    char**		/* list */
);

extern int XFreeGC(
    Display*		/* display */,
    GC			/* gc */
);

extern int XFreeModifiermap(
    XModifierKeymap*	/* modmap */
);

extern int XFreePixmap(
    Display*		/* display */,
    Pixmap		/* pixmap */
);

extern int XGeometry(
    Display*		/* display */,
    int			/* screen */,
    const char*	/* position */,
    const char*	/* default_position */,
    unsigned int	/* bwidth */,
    unsigned int	/* fwidth */,
    unsigned int	/* fheight */,
    int			/* xadder */,
    int			/* yadder */,
    int*		/* x_return */,
    int*		/* y_return */,
    int*		/* width_return */,
    int*		/* height_return */
);

extern int XGetErrorDatabaseText(
    Display*		/* display */,
    const char*	/* name */,
    const char*	/* message */,
    const char*	/* default_string */,
    char*		/* buffer_return */,
    int			/* length */
);

extern int XGetErrorText(
    Display*		/* display */,
    int			/* code */,
    char*		/* buffer_return */,
    int			/* length */
);

extern Bool XGetFontProperty(
    XFontStruct*	/* font_struct */,
    Atom		/* atom */,
    unsigned long*	/* value_return */
);

extern Status XGetGCValues(
    Display*		/* display */,
    GC			/* gc */,
    unsigned long	/* valuemask */,
    XGCValues*		/* values_return */
);

extern Status XGetGeometry(
    Display*		/* display */,
    Drawable		/* d */,
    Window*		/* root_return */,
    int*		/* x_return */,
    int*		/* y_return */,
    unsigned int*	/* width_return */,
    unsigned int*	/* height_return */,
    unsigned int*	/* border_width_return */,
    unsigned int*	/* depth_return */
);

extern Status XGetIconName(
    Display*		/* display */,
    Window		/* w */,
    char**		/* icon_name_return */
);

extern int XGetInputFocus(
    Display*		/* display */,
    Window*		/* focus_return */,
    int*		/* revert_to_return */
);

extern int XGetKeyboardControl(
    Display*		/* display */,
    XKeyboardState*	/* values_return */
);

extern int XGetPointerControl(
    Display*		/* display */,
    int*		/* accel_numerator_return */,
    int*		/* accel_denominator_return */,
    int*		/* threshold_return */
);

extern int XGetPointerMapping(
    Display*		/* display */,
    unsigned char*	/* map_return */,
    int			/* nmap */
);

extern int XGetScreenSaver(
    Display*		/* display */,
    int*		/* timeout_return */,
    int*		/* interval_return */,
    int*		/* prefer_blanking_return */,
    int*		/* allow_exposures_return */
);

extern Status XGetTransientForHint(
    Display*		/* display */,
    Window		/* w */,
    Window*		/* prop_window_return */
);

extern int XGetWindowProperty(
    Display*		/* display */,
    Window		/* w */,
    Atom		/* property */,
    long		/* long_offset */,
    long		/* long_length */,
    Bool		/* delete */,
    Atom		/* req_type */,
    Atom*		/* actual_type_return */,
    int*		/* actual_format_return */,
    unsigned long*	/* nitems_return */,
    unsigned long*	/* bytes_after_return */,
    unsigned char**	/* prop_return */
);

extern Status XGetWindowAttributes(
    Display*		/* display */,
    Window		/* w */,
    XWindowAttributes*	/* window_attributes_return */
);

extern int XGrabButton(
    Display*		/* display */,
    unsigned int	/* button */,
    unsigned int	/* modifiers */,
    Window		/* grab_window */,
    Bool		/* owner_events */,
    unsigned int	/* event_mask */,
    int			/* pointer_mode */,
    int			/* keyboard_mode */,
    Window		/* confine_to */,
    Cursor		/* cursor */
);

extern int XGrabKey(
    Display*		/* display */,
    int			/* keycode */,
    unsigned int	/* modifiers */,
    Window		/* grab_window */,
    Bool		/* owner_events */,
    int			/* pointer_mode */,
    int			/* keyboard_mode */
);

extern int XGrabKeyboard(
    Display*		/* display */,
    Window		/* grab_window */,
    Bool		/* owner_events */,
    int			/* pointer_mode */,
    int			/* keyboard_mode */,
    Time		/* time */
);

extern int XGrabPointer(
    Display*		/* display */,
    Window		/* grab_window */,
    Bool		/* owner_events */,
    unsigned int	/* event_mask */,
    int			/* pointer_mode */,
    int			/* keyboard_mode */,
    Window		/* confine_to */,
    Cursor		/* cursor */,
    Time		/* time */
);

extern int XGrabServer(
    Display*		/* display */
);

extern int XHeightMMOfScreen(
    Screen*		/* screen */
);

extern int XHeightOfScreen(
    Screen*		/* screen */
);

extern int XIfEvent(
    Display*		/* display */,
    XEvent*		/* event_return */,
    Bool (*) (
	       Display*			/* display */,
               XEvent*			/* event */,
               XPointer			/* arg */
             )		/* predicate */,
    XPointer		/* arg */
);

extern int XImageByteOrder(
    Display*		/* display */
);

extern int XInstallColormap(
    Display*		/* display */,
    Colormap		/* colormap */
);

extern KeyCode XKeysymToKeycode(
    Display*		/* display */,
    KeySym		/* keysym */
);

extern int XKillClient(
    Display*		/* display */,
    XID			/* resource */
);

extern Status XLookupColor(
    Display*		/* display */,
    Colormap		/* colormap */,
    const char*	/* color_name */,
    XColor*		/* exact_def_return */,
    XColor*		/* screen_def_return */
);

extern int XLowerWindow(
    Display*		/* display */,
    Window		/* w */
);

extern int XMapRaised(
    Display*		/* display */,
    Window		/* w */
);

extern int XMapSubwindows(
    Display*		/* display */,
    Window		/* w */
);

extern int XMapWindow(
    Display*		/* display */,
    Window		/* w */
);

extern int XMaskEvent(
    Display*		/* display */,
    long		/* event_mask */,
    XEvent*		/* event_return */
);

extern int XMaxCmapsOfScreen(
    Screen*		/* screen */
);

extern int XMinCmapsOfScreen(
    Screen*		/* screen */
);

extern int XMoveResizeWindow(
    Display*		/* display */,
    Window		/* w */,
    int			/* x */,
    int			/* y */,
    unsigned int	/* width */,
    unsigned int	/* height */
);

extern int XMoveWindow(
    Display*		/* display */,
    Window		/* w */,
    int			/* x */,
    int			/* y */
);

extern int XNextEvent(
    Display*		/* display */,
    XEvent*		/* event_return */
);

extern int XNoOp(
    Display*		/* display */
);

extern Status XParseColor(
    Display*		/* display */,
    Colormap		/* colormap */,
    const char*	/* spec */,
    XColor*		/* exact_def_return */
);

extern int XParseGeometry(
    const char*	/* parsestring */,
    int*		/* x_return */,
    int*		/* y_return */,
    unsigned int*	/* width_return */,
    unsigned int*	/* height_return */
);

extern int XPeekEvent(
    Display*		/* display */,
    XEvent*		/* event_return */
);

extern int XPeekIfEvent(
    Display*		/* display */,
    XEvent*		/* event_return */,
    Bool (*) (
	       Display*		/* display */,
               XEvent*		/* event */,
               XPointer		/* arg */
             )		/* predicate */,
    XPointer		/* arg */
);

extern int XPending(
    Display*		/* display */
);

extern int XPlanesOfScreen(
    Screen*		/* screen */
);

extern int XProtocolRevision(
    Display*		/* display */
);

extern int XProtocolVersion(
    Display*		/* display */
);


extern int XPutBackEvent(
    Display*		/* display */,
    XEvent*		/* event */
);

extern int XPutImage(
    Display*		/* display */,
    Drawable		/* d */,
    GC			/* gc */,
    XImage*		/* image */,
    int			/* src_x */,
    int			/* src_y */,
    int			/* dest_x */,
    int			/* dest_y */,
    unsigned int	/* width */,
    unsigned int	/* height */	  
);

extern int XQLength(
    Display*		/* display */
);

extern Status XQueryBestCursor(
    Display*		/* display */,
    Drawable		/* d */,
    unsigned int        /* width */,
    unsigned int	/* height */,
    unsigned int*	/* width_return */,
    unsigned int*	/* height_return */
);

extern Status XQueryBestSize(
    Display*		/* display */,
    int			/* class */,
    Drawable		/* which_screen */,
    unsigned int	/* width */,
    unsigned int	/* height */,
    unsigned int*	/* width_return */,
    unsigned int*	/* height_return */
);

extern Status XQueryBestStipple(
    Display*		/* display */,
    Drawable		/* which_screen */,
    unsigned int	/* width */,
    unsigned int	/* height */,
    unsigned int*	/* width_return */,
    unsigned int*	/* height_return */
);

extern Status XQueryBestTile(
    Display*		/* display */,
    Drawable		/* which_screen */,
    unsigned int	/* width */,
    unsigned int	/* height */,
    unsigned int*	/* width_return */,
    unsigned int*	/* height_return */
);

extern int XQueryColor(
    Display*		/* display */,
    Colormap		/* colormap */,
    XColor*		/* def_in_out */
);

extern int XQueryColors(
    Display*		/* display */,
    Colormap		/* colormap */,
    XColor*		/* defs_in_out */,
    int			/* ncolors */
);

extern Bool XQueryExtension(
    Display*		/* display */,
    const char*	/* name */,
    int*		/* major_opcode_return */,
    int*		/* first_event_return */,
    int*		/* first_error_return */
);

extern int XQueryKeymap(
    Display*		/* display */,
    char [32]		/* keys_return */
);

extern Bool XQueryPointer(
    Display*		/* display */,
    Window		/* w */,
    Window*		/* root_return */,
    Window*		/* child_return */,
    int*		/* root_x_return */,
    int*		/* root_y_return */,
    int*		/* win_x_return */,
    int*		/* win_y_return */,
    unsigned int*       /* mask_return */
);

extern int XQueryTextExtents(
    Display*		/* display */,
    XID			/* font_ID */,
    const char*	/* string */,
    int			/* nchars */,
    int*		/* direction_return */,
    int*		/* font_ascent_return */,
    int*		/* font_descent_return */,
    XCharStruct*	/* overall_return */    
);

extern int XQueryTextExtents16(
    Display*		/* display */,
    XID			/* font_ID */,
    const XChar2b*	/* string */,
    int			/* nchars */,
    int*		/* direction_return */,
    int*		/* font_ascent_return */,
    int*		/* font_descent_return */,
    XCharStruct*	/* overall_return */
);

extern Status XQueryTree(
    Display*		/* display */,
    Window		/* w */,
    Window*		/* root_return */,
    Window*		/* parent_return */,
    Window**		/* children_return */,
    unsigned int*	/* nchildren_return */
);

extern int XRaiseWindow(
    Display*		/* display */,
    Window		/* w */
);

extern int XReadBitmapFile(
    Display*		/* display */,
    Drawable 		/* d */,
    const char*	/* filename */,
    unsigned int*	/* width_return */,
    unsigned int*	/* height_return */,
    Pixmap*		/* bitmap_return */,
    int*		/* x_hot_return */,
    int*		/* y_hot_return */
);

extern int XReadBitmapFileData(
    const char*	/* filename */,
    unsigned int*	/* width_return */,
    unsigned int*	/* height_return */,
    unsigned char**	/* data_return */,
    int*		/* x_hot_return */,
    int*		/* y_hot_return */
);

extern int XRebindKeysym(
    Display*		/* display */,
    KeySym		/* keysym */,
    KeySym*		/* list */,
    int			/* mod_count */,
    const unsigned char*	/* string */,
    int			/* bytes_string */
);

extern int XRecolorCursor(
    Display*		/* display */,
    Cursor		/* cursor */,
    XColor*		/* foreground_color */,
    XColor*		/* background_color */
);

extern int XRefreshKeyboardMapping(
    XMappingEvent*	/* event_map */    
);

extern int XRemoveFromSaveSet(
    Display*		/* display */,
    Window		/* w */
);

extern int XRemoveHost(
    Display*		/* display */,
    XHostAddress*	/* host */
);

extern int XRemoveHosts(
    Display*		/* display */,
    XHostAddress*	/* hosts */,
    int			/* num_hosts */
);

extern int XReparentWindow(
    Display*		/* display */,
    Window		/* w */,
    Window		/* parent */,
    int			/* x */,
    int			/* y */
);

extern int XResetScreenSaver(
    Display*		/* display */
);

extern int XResizeWindow(
    Display*		/* display */,
    Window		/* w */,
    unsigned int	/* width */,
    unsigned int	/* height */
);

extern int XRestackWindows(
    Display*		/* display */,
    Window*		/* windows */,
    int			/* nwindows */
);

extern int XRotateBuffers(
    Display*		/* display */,
    int			/* rotate */
);

extern int XRotateWindowProperties(
    Display*		/* display */,
    Window		/* w */,
    Atom*		/* properties */,
    int			/* num_prop */,
    int			/* npositions */
);

extern int XScreenCount(
    Display*		/* display */
);

extern int XSelectInput(
    Display*		/* display */,
    Window		/* w */,
    long		/* event_mask */
);

extern Status XSendEvent(
    Display*		/* display */,
    Window		/* w */,
    Bool		/* propagate */,
    long		/* event_mask */,
    XEvent*		/* event_send */
);

extern int XSetAccessControl(
    Display*		/* display */,
    int			/* mode */
);

extern int XSetArcMode(
    Display*		/* display */,
    GC			/* gc */,
    int			/* arc_mode */
);

extern int XSetBackground(
    Display*		/* display */,
    GC			/* gc */,
    unsigned long	/* background */
);

extern int XSetClipMask(
    Display*		/* display */,
    GC			/* gc */,
    Pixmap		/* pixmap */
);

extern int XSetClipOrigin(
    Display*		/* display */,
    GC			/* gc */,
    int			/* clip_x_origin */,
    int			/* clip_y_origin */
);

extern int XSetClipRectangles(
    Display*		/* display */,
    GC			/* gc */,
    int			/* clip_x_origin */,
    int			/* clip_y_origin */,
    XRectangle*		/* rectangles */,
    int			/* n */,
    int			/* ordering */
);

extern int XSetCloseDownMode(
    Display*		/* display */,
    int			/* close_mode */
);

extern int XSetCommand(
    Display*		/* display */,
    Window		/* w */,
    char**		/* argv */,
    int			/* argc */
);

extern int XSetDashes(
    Display*		/* display */,
    GC			/* gc */,
    int			/* dash_offset */,
    const char*	/* dash_list */,
    int			/* n */
);

extern int XSetFillRule(
    Display*		/* display */,
    GC			/* gc */,
    int			/* fill_rule */
);

extern int XSetFillStyle(
    Display*		/* display */,
    GC			/* gc */,
    int			/* fill_style */
);

extern int XSetFont(
    Display*		/* display */,
    GC			/* gc */,
    Font		/* font */
);

extern int XSetFontPath(
    Display*		/* display */,
    char**		/* directories */,
    int			/* ndirs */	     
);

extern int XSetForeground(
    Display*		/* display */,
    GC			/* gc */,
    unsigned long	/* foreground */
);

extern int XSetFunction(
    Display*		/* display */,
    GC			/* gc */,
    int			/* function */
);

extern int XSetGraphicsExposures(
    Display*		/* display */,
    GC			/* gc */,
    Bool		/* graphics_exposures */
);

extern int XSetIconName(
    Display*		/* display */,
    Window		/* w */,
    const char*	/* icon_name */
);

extern int XSetInputFocus(
    Display*		/* display */,
    Window		/* focus */,
    int			/* revert_to */,
    Time		/* time */
);

extern int XSetLineAttributes(
    Display*		/* display */,
    GC			/* gc */,
    unsigned int	/* line_width */,
    int			/* line_style */,
    int			/* cap_style */,
    int			/* join_style */
);

extern int XSetModifierMapping(
    Display*		/* display */,
    XModifierKeymap*	/* modmap */
);

extern int XSetPlaneMask(
    Display*		/* display */,
    GC			/* gc */,
    unsigned long	/* plane_mask */
);

extern int XSetPointerMapping(
    Display*		/* display */,
    const unsigned char*	/* map */,
    int			/* nmap */
);

extern int XSetScreenSaver(
    Display*		/* display */,
    int			/* timeout */,
    int			/* interval */,
    int			/* prefer_blanking */,
    int			/* allow_exposures */
);

extern int XSetSelectionOwner(
    Display*		/* display */,
    Atom	        /* selection */,
    Window		/* owner */,
    Time		/* time */
);

extern int XSetState(
    Display*		/* display */,
    GC			/* gc */,
    unsigned long 	/* foreground */,
    unsigned long	/* background */,
    int			/* function */,
    unsigned long	/* plane_mask */
);

extern int XSetStipple(
    Display*		/* display */,
    GC			/* gc */,
    Pixmap		/* stipple */
);

extern int XSetSubwindowMode(
    Display*		/* display */,
    GC			/* gc */,
    int			/* subwindow_mode */
);

extern int XSetTSOrigin(
    Display*		/* display */,
    GC			/* gc */,
    int			/* ts_x_origin */,
    int			/* ts_y_origin */
);

extern int XSetTile(
    Display*		/* display */,
    GC			/* gc */,
    Pixmap		/* tile */
);

extern int XSetWindowBackground(
    Display*		/* display */,
    Window		/* w */,
    unsigned long	/* background_pixel */
);

extern int XSetWindowBackgroundPixmap(
    Display*		/* display */,
    Window		/* w */,
    Pixmap		/* background_pixmap */
);

extern int XSetWindowBorder(
    Display*		/* display */,
    Window		/* w */,
    unsigned long	/* border_pixel */
);

extern int XSetWindowBorderPixmap(
    Display*		/* display */,
    Window		/* w */,
    Pixmap		/* border_pixmap */
);

extern int XSetWindowBorderWidth(
    Display*		/* display */,
    Window		/* w */,
    unsigned int	/* width */
);

extern int XSetWindowColormap(
    Display*		/* display */,
    Window		/* w */,
    Colormap		/* colormap */
);

extern int XStoreBuffer(
    Display*		/* display */,
    const char*	/* bytes */,
    int			/* nbytes */,
    int			/* buffer */
);

extern int XStoreBytes(
    Display*		/* display */,
    const char*	/* bytes */,
    int			/* nbytes */
);

extern int XStoreColor(
    Display*		/* display */,
    Colormap		/* colormap */,
    XColor*		/* color */
);

extern int XStoreColors(
    Display*		/* display */,
    Colormap		/* colormap */,
    XColor*		/* color */,
    int			/* ncolors */
);

extern int XStoreName(
    Display*		/* display */,
    Window		/* w */,
    const char*	/* window_name */
);

extern int XStoreNamedColor(
    Display*		/* display */,
    Colormap		/* colormap */,
    const char*	/* color */,
    unsigned long	/* pixel */,
    int			/* flags */
);

extern int XSync(
    Display*		/* display */,
    Bool		/* discard */
);

extern int XTextExtents(
    XFontStruct*	/* font_struct */,
    const char*	/* string */,
    int			/* nchars */,
    int*		/* direction_return */,
    int*		/* font_ascent_return */,
    int*		/* font_descent_return */,
    XCharStruct*	/* overall_return */
);

extern int XTextExtents16(
    XFontStruct*	/* font_struct */,
    const XChar2b*	/* string */,
    int			/* nchars */,
    int*		/* direction_return */,
    int*		/* font_ascent_return */,
    int*		/* font_descent_return */,
    XCharStruct*	/* overall_return */
);

extern int XTextWidth(
    XFontStruct*	/* font_struct */,
    const char*	/* string */,
    int			/* count */
);

extern int XTextWidth16(
    XFontStruct*	/* font_struct */,
    const XChar2b*	/* string */,
    int			/* count */
);

extern Bool XTranslateCoordinates(
    Display*		/* display */,
    Window		/* src_w */,
    Window		/* dest_w */,
    int			/* src_x */,
    int			/* src_y */,
    int*		/* dest_x_return */,
    int*		/* dest_y_return */,
    Window*		/* child_return */
);

extern int XUndefineCursor(
    Display*		/* display */,
    Window		/* w */
);

extern int XUngrabButton(
    Display*		/* display */,
    unsigned int	/* button */,
    unsigned int	/* modifiers */,
    Window		/* grab_window */
);

extern int XUngrabKey(
    Display*		/* display */,
    int			/* keycode */,
    unsigned int	/* modifiers */,
    Window		/* grab_window */
);

extern int XUngrabKeyboard(
    Display*		/* display */,
    Time		/* time */
);

extern int XUngrabPointer(
    Display*		/* display */,
    Time		/* time */
);

extern int XUngrabServer(
    Display*		/* display */
);

extern int XUninstallColormap(
    Display*		/* display */,
    Colormap		/* colormap */
);

extern int XUnloadFont(
    Display*		/* display */,
    Font		/* font */
);

extern int XUnmapSubwindows(
    Display*		/* display */,
    Window		/* w */
);

extern int XUnmapWindow(
    Display*		/* display */,
    Window		/* w */
);

extern int XVendorRelease(
    Display*		/* display */
);

extern int XWarpPointer(
    Display*		/* display */,
    Window		/* src_w */,
    Window		/* dest_w */,
    int			/* src_x */,
    int			/* src_y */,
    unsigned int	/* src_width */,
    unsigned int	/* src_height */,
    int			/* dest_x */,
    int			/* dest_y */	     
);

extern int XWidthMMOfScreen(
    Screen*		/* screen */
);

extern int XWidthOfScreen(
    Screen*		/* screen */
);

extern int XWindowEvent(
    Display*		/* display */,
    Window		/* w */,
    long		/* event_mask */,
    XEvent*		/* event_return */
);

extern int XWriteBitmapFile(
    Display*		/* display */,
    const char*	/* filename */,
    Pixmap		/* bitmap */,
    unsigned int	/* width */,
    unsigned int	/* height */,
    int			/* x_hot */,
    int			/* y_hot */		     
);

extern Bool XSupportsLocale (void);

extern char *XSetLocaleModifiers(
    const char*		/* modifier_list */
);

extern XOM XOpenOM(
    Display*			/* display */,
    struct _XrmHashBucketRec*	/* rdb */,
    const char*		/* res_name */,
    const char*		/* res_class */
);

extern Status XCloseOM(
    XOM			/* om */
);

extern char *XSetOMValues(
    XOM			/* om */,
    ...
);

extern char *XGetOMValues(
    XOM			/* om */,
    ...
);

extern Display *XDisplayOfOM(
    XOM			/* om */
);

extern char *XLocaleOfOM(
    XOM			/* om */
);

extern XOC XCreateOC(
    XOM			/* om */,
    ...
);

extern void XDestroyOC(
    XOC			/* oc */
);

extern XOM XOMOfOC(
    XOC			/* oc */
);

extern char *XSetOCValues(
    XOC			/* oc */,
    ...
);

extern char *XGetOCValues(
    XOC			/* oc */,
    ...
);

extern XFontSet XCreateFontSet(
    Display*		/* display */,
    const char*	/* base_font_name_list */,
    char***		/* missing_charset_list */,
    int*		/* missing_charset_count */,
    char**		/* def_string */
);

extern void XFreeFontSet(
    Display*		/* display */,
    XFontSet		/* font_set */
);

extern int XFontsOfFontSet(
    XFontSet		/* font_set */,
    XFontStruct***	/* font_struct_list */,
    char***		/* font_name_list */
);

extern char *XBaseFontNameListOfFontSet(
    XFontSet		/* font_set */
);

extern char *XLocaleOfFontSet(
    XFontSet		/* font_set */
);

extern Bool XContextDependentDrawing(
    XFontSet		/* font_set */
);

extern Bool XDirectionalDependentDrawing(
    XFontSet		/* font_set */
);

extern Bool XContextualDrawing(
    XFontSet		/* font_set */
);

extern XFontSetExtents *XExtentsOfFontSet(
    XFontSet		/* font_set */
);

extern int XmbTextEscapement(
    XFontSet		/* font_set */,
    const char*	/* text */,
    int			/* bytes_text */
);

extern int XwcTextEscapement(
    XFontSet		/* font_set */,
    const wchar_t*	/* text */,
    int			/* num_wchars */
);

extern int XmbTextExtents(
    XFontSet		/* font_set */,
    const char*	/* text */,
    int			/* bytes_text */,
    XRectangle*		/* overall_ink_return */,
    XRectangle*		/* overall_logical_return */
);

extern int XwcTextExtents(
    XFontSet		/* font_set */,
    const wchar_t*	/* text */,
    int			/* num_wchars */,
    XRectangle*		/* overall_ink_return */,
    XRectangle*		/* overall_logical_return */
);

extern Status XmbTextPerCharExtents(
    XFontSet		/* font_set */,
    const char*	/* text */,
    int			/* bytes_text */,
    XRectangle*		/* ink_extents_buffer */,
    XRectangle*		/* logical_extents_buffer */,
    int			/* buffer_size */,
    int*		/* num_chars */,
    XRectangle*		/* overall_ink_return */,
    XRectangle*		/* overall_logical_return */
);

extern Status XwcTextPerCharExtents(
    XFontSet		/* font_set */,
    const wchar_t*	/* text */,
    int			/* num_wchars */,
    XRectangle*		/* ink_extents_buffer */,
    XRectangle*		/* logical_extents_buffer */,
    int			/* buffer_size */,
    int*		/* num_chars */,
    XRectangle*		/* overall_ink_return */,
    XRectangle*		/* overall_logical_return */
);


extern void XmbDrawText(
    Display*		/* display */,
    Drawable		/* d */,
    GC			/* gc */,
    int			/* x */,
    int			/* y */,
    XmbTextItem*	/* text_items */,
    int			/* nitems */
);

extern void XwcDrawText(
    Display*		/* display */,
    Drawable		/* d */,
    GC			/* gc */,
    int			/* x */,
    int			/* y */,
    XwcTextItem*	/* text_items */,
    int			/* nitems */
);

extern void XmbDrawString(
    Display*		/* display */,
    Drawable		/* d */,
    XFontSet		/* font_set */,
    GC			/* gc */,
    int			/* x */,
    int			/* y */,
    const char*	/* text */,
    int			/* bytes_text */
);

extern void XwcDrawString(
    Display*		/* display */,
    Drawable		/* d */,
    XFontSet		/* font_set */,
    GC			/* gc */,
    int			/* x */,
    int			/* y */,
    const wchar_t*	/* text */,
    int			/* num_wchars */
);

extern void XmbDrawImageString(
    Display*		/* display */,
    Drawable		/* d */,
    XFontSet		/* font_set */,
    GC			/* gc */,
    int			/* x */,
    int			/* y */,
    const char*	/* text */,
    int			/* bytes_text */
);

extern void XwcDrawImageString(
    Display*		/* display */,
    Drawable		/* d */,
    XFontSet		/* font_set */,
    GC			/* gc */,
    int			/* x */,
    int			/* y */,
    const wchar_t*	/* text */,
    int			/* num_wchars */
);

extern XIM XOpenIM(
    Display*			/* dpy */,
    struct _XrmHashBucketRec*	/* rdb */,
    char*			/* res_name */,
    char*			/* res_class */
);

extern Status XCloseIM(
    XIM /* im */
);

extern char *XGetIMValues(
    XIM /* im */, ...
);

extern char *XSetIMValues(
    XIM /* im */, ...
);

extern Display *XDisplayOfIM(
    XIM /* im */
);

extern char *XLocaleOfIM(
    XIM /* im*/
);

extern XIC XCreateIC(
    XIM /* im */, ...
);

extern void XDestroyIC(
    XIC /* ic */
);

extern void XSetICFocus(
    XIC /* ic */
);

extern void XUnsetICFocus(
    XIC /* ic */
);

extern wchar_t *XwcResetIC(
    XIC /* ic */
);

extern char *XmbResetIC(
    XIC /* ic */
);

extern char *XSetICValues(
    XIC /* ic */, ...
);

extern char *XGetICValues(
    XIC /* ic */, ...
);

extern XIM XIMOfIC(
    XIC /* ic */
);

extern Bool XFilterEvent(
    XEvent*	/* event */,
    Window	/* window */
);

extern int XmbLookupString(
    XIC			/* ic */,
    XKeyPressedEvent*	/* event */,
    char*		/* buffer_return */,
    int			/* bytes_buffer */,
    KeySym*		/* keysym_return */,
    Status*		/* status_return */
);

extern int XwcLookupString(
    XIC			/* ic */,
    XKeyPressedEvent*	/* event */,
    wchar_t*		/* buffer_return */,
    int			/* wchars_buffer */,
    KeySym*		/* keysym_return */,
    Status*		/* status_return */
);

extern XVaNestedList XVaCreateNestedList(
    int /*unused*/, ...
);

/* internal connections for IMs */

extern Bool XRegisterIMInstantiateCallback(
    Display*			/* dpy */,
    struct _XrmHashBucketRec*	/* rdb */,
    char*			/* res_name */,
    char*			/* res_class */,
    XIMProc			/* callback */,
    XPointer*			/* client_data */
);

extern Bool XUnregisterIMInstantiateCallback(
    Display*			/* dpy */,
    struct _XrmHashBucketRec*	/* rdb */,
    char*			/* res_name */,
    char*			/* res_class */,
    XIMProc			/* callback */,
    XPointer*			/* client_data */
);

extern Status XInternalConnectionNumbers(
    Display*			/* dpy */,
    int**			/* fd_return */,
    int*			/* count_return */
);

extern void XProcessInternalConnection(
    Display*			/* dpy */,
    int				/* fd */
);

extern Status XAddConnectionWatch(
    Display*			/* dpy */,
    XConnectionWatchProc	/* callback */,
    XPointer			/* client_data */
);

extern void XRemoveConnectionWatch(
    Display*			/* dpy */,
    XConnectionWatchProc	/* callback */,
    XPointer			/* client_data */
);

%}

extern XFontStruct *XLoadQueryFont(
    Display*		/* display */,
    const char*	/* name */
);

extern XFontStruct *XQueryFont(
    Display*		/* display */,
    XID			/* font_ID */
);


extern XTimeCoord *XGetMotionEvents(
    Display*		/* display */,
    Window		/* w */,
    Time		/* start */,
    Time		/* stop */,
    int*		/* nevents_return */
);

extern XModifierKeymap *XDeleteModifiermapEntry(
    XModifierKeymap*	/* modmap */,
    KeyCode		/* keycode_entry */,
    int			/* modifier */
);

extern XModifierKeymap	*XGetModifierMapping(
    Display*		/* display */
);

extern XModifierKeymap	*XInsertModifiermapEntry(
    XModifierKeymap*	/* modmap */,
    KeyCode		/* keycode_entry */,
    int			/* modifier */    
);

extern XModifierKeymap *XNewModifiermap(
    int			/* max_keys_per_mod */
);

extern XImage *XCreateImage(
    Display*		/* display */,
    Visual*		/* visual */,
    unsigned int	/* depth */,
    int			/* format */,
    int			/* offset */,
    char*		/* data */,
    unsigned int	/* width */,
    unsigned int	/* height */,
    int			/* bitmap_pad */,
    int			/* bytes_per_line */
);
extern Status XInitImage(
    XImage*		/* image */
);
extern XImage *XGetImage(
    Display*		/* display */,
    Drawable		/* d */,
    int			/* x */,
    int			/* y */,
    unsigned int	/* width */,
    unsigned int	/* height */,
    unsigned long	/* plane_mask */,
    int			/* format */
);
extern XImage *XGetSubImage(
    Display*		/* display */,
    Drawable		/* d */,
    int			/* x */,
    int			/* y */,
    unsigned int	/* width */,
    unsigned int	/* height */,
    unsigned long	/* plane_mask */,
    int			/* format */,
    XImage*		/* dest_image */,
    int			/* dest_x */,
    int			/* dest_y */
);

/* 
 * X function declarations.
 */
extern Display *XOpenDisplay(
    const char*	/* display_name */
);

extern void XrmInitialize(
    void
);

extern char *XFetchBytes(
    Display*		/* display */,
    int*		/* nbytes_return */
);
extern char *XFetchBuffer(
    Display*		/* display */,
    int*		/* nbytes_return */,
    int			/* buffer */
);
extern char *XGetAtomName(
    Display*		/* display */,
    Atom		/* atom */
);
extern Status XGetAtomNames(
    Display*		/* dpy */,
    Atom*		/* atoms */,
    int			/* count */,
    char**		/* names_return */
);
extern char *XGetDefault(
    Display*		/* display */,
    const char*	/* program */,
    const char*	/* option */		  
);
extern char *XDisplayName(
    const char*	/* string */
);
extern char *XKeysymToString(
    KeySym		/* keysym */
);

extern int (*XSynchronize(
    Display*		/* display */,
    Bool		/* onoff */
))(
    Display*		/* display */
);
extern int (*XSetAfterFunction(
    Display*		/* display */,
    int (*) (
	     Display*	/* display */
            )		/* procedure */
))(
    Display*		/* display */
);
extern Atom XInternAtom(
    Display*		/* display */,
    const char*	/* atom_name */,
    Bool		/* only_if_exists */		 
);
extern Status XInternAtoms(
    Display*		/* dpy */,
    char**		/* names */,
    int			/* count */,
    Bool		/* onlyIfExists */,
    Atom*		/* atoms_return */
);
extern Colormap XCopyColormapAndFree(
    Display*		/* display */,
    Colormap		/* colormap */
);
extern Colormap XCreateColormap(
    Display*		/* display */,
    Window		/* w */,
    Visual*		/* visual */,
    int			/* alloc */			 
);
extern Cursor XCreatePixmapCursor(
    Display*		/* display */,
    Pixmap		/* source */,
    Pixmap		/* mask */,
    XColor*		/* foreground_color */,
    XColor*		/* background_color */,
    unsigned int	/* x */,
    unsigned int	/* y */			   
);
extern Cursor XCreateGlyphCursor(
    Display*		/* display */,
    Font		/* source_font */,
    Font		/* mask_font */,
    unsigned int	/* source_char */,
    unsigned int	/* mask_char */,
    XColor const *	/* foreground_color */,
    XColor const *	/* background_color */
);
extern Cursor XCreateFontCursor(
    Display*		/* display */,
    unsigned int	/* shape */
);
extern Font XLoadFont(
    Display*		/* display */,
    const char*	/* name */
);
extern GC XCreateGC(
    Display*		/* display */,
    Drawable		/* d */,
    unsigned long	/* valuemask */,
    XGCValues*		/* values */
);
extern GContext XGContextFromGC(
    GC			/* gc */
);
extern void XFlushGC(
    Display*		/* display */,
    GC			/* gc */
);
extern Pixmap XCreatePixmap(
    Display*		/* display */,
    Drawable		/* d */,
    unsigned int	/* width */,
    unsigned int	/* height */,
    unsigned int	/* depth */		        
);
extern Pixmap XCreateBitmapFromData(
    Display*		/* display */,
    Drawable		/* d */,
    const char*	/* data */,
    unsigned int	/* width */,
    unsigned int	/* height */
);
extern Pixmap XCreatePixmapFromBitmapData(
    Display*		/* display */,
    Drawable		/* d */,
    char*		/* data */,
    unsigned int	/* width */,
    unsigned int	/* height */,
    unsigned long	/* fg */,
    unsigned long	/* bg */,
    unsigned int	/* depth */
);
extern Window XCreateSimpleWindow(
    Display*		/* display */,
    Window		/* parent */,
    int			/* x */,
    int			/* y */,
    unsigned int	/* width */,
    unsigned int	/* height */,
    unsigned int	/* border_width */,
    unsigned long	/* border */,
    unsigned long	/* background */
);
extern Window XGetSelectionOwner(
    Display*		/* display */,
    Atom		/* selection */
);
extern Window XCreateWindow(
    Display*		/* display */,
    Window		/* parent */,
    int			/* x */,
    int			/* y */,
    unsigned int	/* width */,
    unsigned int	/* height */,
    unsigned int	/* border_width */,
    int			/* depth */,
    unsigned int	/* class */,
    Visual*		/* visual */,
    unsigned long	/* valuemask */,
    XSetWindowAttributes*	/* attributes */
); 
extern Colormap *XListInstalledColormaps(
    Display*		/* display */,
    Window		/* w */,
    int*		/* num_return */
);
extern char **XListFonts(
    Display*		/* display */,
    const char*	/* pattern */,
    int			/* maxnames */,
    int*		/* actual_count_return */
);
extern char **XListFontsWithInfo(
    Display*		/* display */,
    const char*	/* pattern */,
    int			/* maxnames */,
    int*		/* count_return */,
    XFontStruct**	/* info_return */
);
extern char **XGetFontPath(
    Display*		/* display */,
    int*		/* npaths_return */
);
extern char **XListExtensions(
    Display*		/* display */,
    int*		/* nextensions_return */
);
extern Atom *XListProperties(
    Display*		/* display */,
    Window		/* w */,
    int*		/* num_prop_return */
);
extern XHostAddress *XListHosts(
    Display*		/* display */,
    int*		/* nhosts_return */,
    Bool*		/* state_return */
);
extern KeySym XKeycodeToKeysym(
    Display*		/* display */,
    KeyCode		/* keycode */,
    int			/* index */
);
extern KeySym XLookupKeysym(
    XKeyEvent*		/* key_event */,
    int			/* index */
);
extern KeySym *XGetKeyboardMapping(
    Display*		/* display */,
    KeyCode		/* first_keycode */,
    int			/* keycode_count */,
    int*		/* keysyms_per_keycode_return */
);
extern KeySym XStringToKeysym(
    const char*	/* string */
);
extern long XMaxRequestSize(
    Display*		/* display */
);
extern long XExtendedMaxRequestSize(
    Display*		/* display */
);
extern char *XResourceManagerString(
    Display*		/* display */
);
extern char *XScreenResourceString(
	Screen*		/* screen */
);
extern unsigned long XDisplayMotionBufferSize(
    Display*		/* display */
);
extern VisualID XVisualIDFromVisual(
    Visual*		/* visual */
);

/* multithread routines */

extern Status XInitThreads(
    void
);

extern void XLockDisplay(
    Display*		/* display */
);

extern void XUnlockDisplay(
    Display*		/* display */
);

/* routines for dealing with extensions */

extern XExtCodes *XInitExtension(
    Display*		/* display */,
    const char*	/* name */
);

extern XExtCodes *XAddExtension(
    Display*		/* display */
);
extern XExtData *XFindOnExtensionList(
    XExtData**		/* structure */,
    int			/* number */
);

/* these are routines for which there are also macros */
extern Window XRootWindow(
    Display*		/* display */,
    int			/* screen_number */
);
extern Window XDefaultRootWindow(
    Display*		/* display */
);
extern Window XRootWindowOfScreen(
    Screen*		/* screen */
);
extern Visual *XDefaultVisual(
    Display*		/* display */,
    int			/* screen_number */
);
extern Visual *XDefaultVisualOfScreen(
    Screen*		/* screen */
);
extern GC XDefaultGC(
    Display*		/* display */,
    int			/* screen_number */
);
extern GC XDefaultGCOfScreen(
    Screen*		/* screen */
);
extern unsigned long XBlackPixel(
    Display*		/* display */,
    int			/* screen_number */
);
extern unsigned long XWhitePixel(
    Display*		/* display */,
    int			/* screen_number */
);
extern unsigned long XAllPlanes(
    void
);
extern unsigned long XBlackPixelOfScreen(
    Screen*		/* screen */
);
extern unsigned long XWhitePixelOfScreen(
    Screen*		/* screen */
);
extern unsigned long XNextRequest(
    Display*		/* display */
);
extern unsigned long XLastKnownRequestProcessed(
    Display*		/* display */
);
extern char *XServerVendor(
    Display*		/* display */
);
extern char *XDisplayString(
    Display*		/* display */
);
extern Colormap XDefaultColormap(
    Display*		/* display */,
    int			/* screen_number */
);
extern Colormap XDefaultColormapOfScreen(
    Screen*		/* screen */
);
extern Display *XDisplayOfScreen(
    Screen*		/* screen */
);
extern Screen *XScreenOfDisplay(
    Display*		/* display */,
    int			/* screen_number */
);
extern Screen *XDefaultScreenOfDisplay(
    Display*		/* display */
);
extern long XEventMaskOfScreen(
    Screen*		/* screen */
);

extern int XScreenNumberOfScreen(
    Screen*		/* screen */
);

extern XErrorHandler XSetErrorHandler (
    XErrorHandler	/* handler */
);


extern XIOErrorHandler XSetIOErrorHandler (
    XIOErrorHandler	/* handler */
);


extern XPixmapFormatValues *XListPixmapFormats(
    Display*		/* display */,
    int*		/* count_return */
);
extern int *XListDepths(
    Display*		/* display */,
    int			/* screen_number */,
    int*		/* count_return */
);

/* ICCCM routines for things that don't require special include files; */
/* other declarations are given in Xutil.h                             */
extern Status XReconfigureWMWindow(
    Display*		/* display */,
    Window		/* w */,
    int			/* screen_number */,
    unsigned int	/* mask */,
    XWindowChanges*	/* changes */
);

extern Status XGetWMProtocols(
    Display*		/* display */,
    Window		/* w */,
    Atom**		/* protocols_return */,
    int*		/* count_return */
);
extern Status XSetWMProtocols(
    Display*		/* display */,
    Window		/* w */,
    Atom*		/* protocols */,
    int			/* count */
);
extern Status XIconifyWindow(
    Display*		/* display */,
    Window		/* w */,
    int			/* screen_number */
);
extern Status XWithdrawWindow(
    Display*		/* display */,
    Window		/* w */,
    int			/* screen_number */
);
extern Status XGetCommand(
    Display*		/* display */,
    Window		/* w */,
    char***		/* argv_return */,
    int*		/* argc_return */
);
extern Status XGetWMColormapWindows(
    Display*		/* display */,
    Window		/* w */,
    Window**		/* windows_return */,
    int*		/* count_return */
);
extern Status XSetWMColormapWindows(
    Display*		/* display */,
    Window		/* w */,
    Window*		/* colormap_windows */,
    int			/* count */
);
extern void XFreeStringList(
    char**		/* list */
);
extern int XSetTransientForHint(
    Display*		/* display */,
    Window		/* w */,
    Window		/* prop_window */
);

/* The following are given in alphabetical order */

extern int XActivateScreenSaver(
    Display*		/* display */
);

extern int XAddHost(
    Display*		/* display */,
    XHostAddress*	/* host */
);

extern int XAddHosts(
    Display*		/* display */,
    XHostAddress*	/* hosts */,
    int			/* num_hosts */    
);

extern int XAddToExtensionList(
    struct _XExtData**	/* structure */,
    XExtData*		/* ext_data */
);

extern int XAddToSaveSet(
    Display*		/* display */,
    Window		/* w */
);

extern Status XAllocColor(
    Display*		/* display */,
    Colormap		/* colormap */,
    XColor*		/* screen_in_out */
);

extern Status XAllocColorCells(
    Display*		/* display */,
    Colormap		/* colormap */,
    Bool	        /* contig */,
    unsigned long*	/* plane_masks_return */,
    unsigned int	/* nplanes */,
    unsigned long*	/* pixels_return */,
    unsigned int 	/* npixels */
);

extern Status XAllocColorPlanes(
    Display*		/* display */,
    Colormap		/* colormap */,
    Bool		/* contig */,
    unsigned long*	/* pixels_return */,
    int			/* ncolors */,
    int			/* nreds */,
    int			/* ngreens */,
    int			/* nblues */,
    unsigned long*	/* rmask_return */,
    unsigned long*	/* gmask_return */,
    unsigned long*	/* bmask_return */
);

extern Status XAllocNamedColor(
    Display*		/* display */,
    Colormap		/* colormap */,
    const char*	/* color_name */,
    XColor*		/* screen_def_return */,
    XColor*		/* exact_def_return */
);

extern int XAllowEvents(
    Display*		/* display */,
    int			/* event_mode */,
    Time		/* time */
);

extern int XAutoRepeatOff(
    Display*		/* display */
);

extern int XAutoRepeatOn(
    Display*		/* display */
);

extern int XBell(
    Display*		/* display */,
    int			/* percent */
);

extern int XBitmapBitOrder(
    Display*		/* display */
);

extern int XBitmapPad(
    Display*		/* display */
);

extern int XBitmapUnit(
    Display*		/* display */
);

extern int XCellsOfScreen(
    Screen*		/* screen */
);

extern int XChangeActivePointerGrab(
    Display*		/* display */,
    unsigned int	/* event_mask */,
    Cursor		/* cursor */,
    Time		/* time */
);

extern int XChangeGC(
    Display*		/* display */,
    GC			/* gc */,
    unsigned long	/* valuemask */,
    XGCValues*		/* values */
);

extern int XChangeKeyboardControl(
    Display*		/* display */,
    unsigned long	/* value_mask */,
    XKeyboardControl*	/* values */
);

extern int XChangeKeyboardMapping(
    Display*		/* display */,
    int			/* first_keycode */,
    int			/* keysyms_per_keycode */,
    KeySym*		/* keysyms */,
    int			/* num_codes */
);

extern int XChangePointerControl(
    Display*		/* display */,
    Bool		/* do_accel */,
    Bool		/* do_threshold */,
    int			/* accel_numerator */,
    int			/* accel_denominator */,
    int			/* threshold */
);

extern int XChangeProperty(
    Display*		/* display */,
    Window		/* w */,
    Atom		/* property */,
    Atom		/* type */,
    int			/* format */,
    int			/* mode */,
    const unsigned char*	/* data */,
    int			/* nelements */
);

extern int XChangeSaveSet(
    Display*		/* display */,
    Window		/* w */,
    int			/* change_mode */
);

extern int XChangeWindowAttributes(
    Display*		/* display */,
    Window		/* w */,
    unsigned long	/* valuemask */,
    XSetWindowAttributes* /* attributes */
);

extern Bool XCheckIfEvent(
    Display*		/* display */,
    XEvent*		/* event_return */,
    Bool (*) (
	       Display*			/* display */,
               XEvent*			/* event */,
               XPointer			/* arg */
             )		/* predicate */,
    XPointer		/* arg */
);

extern Bool XCheckMaskEvent(
    Display*		/* display */,
    long		/* event_mask */,
    XEvent*		/* event_return */
);

extern Bool XCheckTypedEvent(
    Display*		/* display */,
    int			/* event_type */,
    XEvent*		/* event_return */
);

extern Bool XCheckTypedWindowEvent(
    Display*		/* display */,
    Window		/* w */,
    int			/* event_type */,
    XEvent*		/* event_return */
);

extern Bool XCheckWindowEvent(
    Display*		/* display */,
    Window		/* w */,
    long		/* event_mask */,
    XEvent*		/* event_return */
);

extern int XCirculateSubwindows(
    Display*		/* display */,
    Window		/* w */,
    int			/* direction */
);

extern int XCirculateSubwindowsDown(
    Display*		/* display */,
    Window		/* w */
);

extern int XCirculateSubwindowsUp(
    Display*		/* display */,
    Window		/* w */
);

extern int XClearArea(
    Display*		/* display */,
    Window		/* w */,
    int			/* x */,
    int			/* y */,
    unsigned int	/* width */,
    unsigned int	/* height */,
    Bool		/* exposures */
);

extern int XClearWindow(
    Display*		/* display */,
    Window		/* w */
);

extern int XCloseDisplay(
    Display*		/* display */
);

extern int XConfigureWindow(
    Display*		/* display */,
    Window		/* w */,
    unsigned int	/* value_mask */,
    XWindowChanges*	/* values */		 
);

extern int XConnectionNumber(
    Display*		/* display */
);

extern int XConvertSelection(
    Display*		/* display */,
    Atom		/* selection */,
    Atom 		/* target */,
    Atom		/* property */,
    Window		/* requestor */,
    Time		/* time */
);

extern int XCopyArea(
    Display*		/* display */,
    Drawable		/* src */,
    Drawable		/* dest */,
    GC			/* gc */,
    int			/* src_x */,
    int			/* src_y */,
    unsigned int	/* width */,
    unsigned int	/* height */,
    int			/* dest_x */,
    int			/* dest_y */
);

extern int XCopyGC(
    Display*		/* display */,
    GC			/* src */,
    unsigned long	/* valuemask */,
    GC			/* dest */
);

extern int XCopyPlane(
    Display*		/* display */,
    Drawable		/* src */,
    Drawable		/* dest */,
    GC			/* gc */,
    int			/* src_x */,
    int			/* src_y */,
    unsigned int	/* width */,
    unsigned int	/* height */,
    int			/* dest_x */,
    int			/* dest_y */,
    unsigned long	/* plane */
);

extern int XDefaultDepth(
    Display*		/* display */,
    int			/* screen_number */
);

extern int XDefaultDepthOfScreen(
    Screen*		/* screen */
);

extern int XDefaultScreen(
    Display*		/* display */
);

extern int XDefineCursor(
    Display*		/* display */,
    Window		/* w */,
    Cursor		/* cursor */
);

extern int XDeleteProperty(
    Display*		/* display */,
    Window		/* w */,
    Atom		/* property */
);

extern int XDestroyWindow(
    Display*		/* display */,
    Window		/* w */
);

extern int XDestroySubwindows(
    Display*		/* display */,
    Window		/* w */
);

extern int XDoesBackingStore(
    Screen*		/* screen */    
);

extern Bool XDoesSaveUnders(
    Screen*		/* screen */
);

extern int XDisableAccessControl(
    Display*		/* display */
);


extern int XDisplayCells(
    Display*		/* display */,
    int			/* screen_number */
);

extern int XDisplayHeight(
    Display*		/* display */,
    int			/* screen_number */
);

extern int XDisplayHeightMM(
    Display*		/* display */,
    int			/* screen_number */
);

extern int XDisplayKeycodes(
    Display*		/* display */,
    int*		/* min_keycodes_return */,
    int*		/* max_keycodes_return */
);

extern int XDisplayPlanes(
    Display*		/* display */,
    int			/* screen_number */
);

extern int XDisplayWidth(
    Display*		/* display */,
    int			/* screen_number */
);

extern int XDisplayWidthMM(
    Display*		/* display */,
    int			/* screen_number */
);

extern int XDrawArc(
    Display*		/* display */,
    Drawable		/* d */,
    GC			/* gc */,
    int			/* x */,
    int			/* y */,
    unsigned int	/* width */,
    unsigned int	/* height */,
    int			/* angle1 */,
    int			/* angle2 */
);

extern int XDrawArcs(
    Display*		/* display */,
    Drawable		/* d */,
    GC			/* gc */,
    XArc*		/* arcs */,
    int			/* narcs */
);

extern int XDrawImageString(
    Display*		/* display */,
    Drawable		/* d */,
    GC			/* gc */,
    int			/* x */,
    int			/* y */,
    const char*	/* string */,
    int			/* length */
);

extern int XDrawImageString16(
    Display*		/* display */,
    Drawable		/* d */,
    GC			/* gc */,
    int			/* x */,
    int			/* y */,
    const XChar2b*	/* string */,
    int			/* length */
);

extern int XDrawLine(
    Display*		/* display */,
    Drawable		/* d */,
    GC			/* gc */,
    int			/* x1 */,
    int			/* y1 */,
    int			/* x2 */,
    int			/* y2 */
);

extern int XDrawLines(
    Display*		/* display */,
    Drawable		/* d */,
    GC			/* gc */,
    XPoint*		/* points */,
    int			/* npoints */,
    int			/* mode */
);

extern int XDrawPoint(
    Display*		/* display */,
    Drawable		/* d */,
    GC			/* gc */,
    int			/* x */,
    int			/* y */
);

extern int XDrawPoints(
    Display*		/* display */,
    Drawable		/* d */,
    GC			/* gc */,
    XPoint*		/* points */,
    int			/* npoints */,
    int			/* mode */
);

extern int XDrawRectangle(
    Display*		/* display */,
    Drawable		/* d */,
    GC			/* gc */,
    int			/* x */,
    int			/* y */,
    unsigned int	/* width */,
    unsigned int	/* height */
);

extern int XDrawRectangles(
    Display*		/* display */,
    Drawable		/* d */,
    GC			/* gc */,
    XRectangle*		/* rectangles */,
    int			/* nrectangles */
);

extern int XDrawSegments(
    Display*		/* display */,
    Drawable		/* d */,
    GC			/* gc */,
    XSegment*		/* segments */,
    int			/* nsegments */
);

extern int XDrawString(
    Display*		/* display */,
    Drawable		/* d */,
    GC			/* gc */,
    int			/* x */,
    int			/* y */,
    const char*	/* string */,
    int			/* length */
);

extern int XDrawString16(
    Display*		/* display */,
    Drawable		/* d */,
    GC			/* gc */,
    int			/* x */,
    int			/* y */,
    const XChar2b*	/* string */,
    int			/* length */
);

extern int XDrawText(
    Display*		/* display */,
    Drawable		/* d */,
    GC			/* gc */,
    int			/* x */,
    int			/* y */,
    XTextItem*		/* items */,
    int			/* nitems */
);

extern int XDrawText16(
    Display*		/* display */,
    Drawable		/* d */,
    GC			/* gc */,
    int			/* x */,
    int			/* y */,
    XTextItem16*	/* items */,
    int			/* nitems */
);

extern int XEnableAccessControl(
    Display*		/* display */
);

extern int XEventsQueued(
    Display*		/* display */,
    int			/* mode */
);

extern Status XFetchName(
    Display*		/* display */,
    Window		/* w */,
    char**		/* window_name_return */
);

extern int XFillArc(
    Display*		/* display */,
    Drawable		/* d */,
    GC			/* gc */,
    int			/* x */,
    int			/* y */,
    unsigned int	/* width */,
    unsigned int	/* height */,
    int			/* angle1 */,
    int			/* angle2 */
);

extern int XFillArcs(
    Display*		/* display */,
    Drawable		/* d */,
    GC			/* gc */,
    XArc*		/* arcs */,
    int			/* narcs */
);

extern int XFillPolygon(
    Display*		/* display */,
    Drawable		/* d */,
    GC			/* gc */,
    XPoint*		/* points */,
    int			/* npoints */,
    int			/* shape */,
    int			/* mode */
);

extern int XFillRectangle(
    Display*		/* display */,
    Drawable		/* d */,
    GC			/* gc */,
    int			/* x */,
    int			/* y */,
    unsigned int	/* width */,
    unsigned int	/* height */
);

extern int XFillRectangles(
    Display*		/* display */,
    Drawable		/* d */,
    GC			/* gc */,
    XRectangle*		/* rectangles */,
    int			/* nrectangles */
);

extern int XFlush(
    Display*		/* display */
);

extern int XForceScreenSaver(
    Display*		/* display */,
    int			/* mode */
);

extern int XFree(
    void*		/* data */
);

extern int XFreeColormap(
    Display*		/* display */,
    Colormap		/* colormap */
);

extern int XFreeColors(
    Display*		/* display */,
    Colormap		/* colormap */,
    unsigned long*	/* pixels */,
    int			/* npixels */,
    unsigned long	/* planes */
);

extern int XFreeCursor(
    Display*		/* display */,
    Cursor		/* cursor */
);

extern int XFreeExtensionList(
    char**		/* list */    
);

extern int XFreeFont(
    Display*		/* display */,
    XFontStruct*	/* font_struct */
);

extern int XFreeFontInfo(
    char**		/* names */,
    XFontStruct*	/* free_info */,
    int			/* actual_count */
);

extern int XFreeFontNames(
    char**		/* list */
);

extern int XFreeFontPath(
    char**		/* list */
);

extern int XFreeGC(
    Display*		/* display */,
    GC			/* gc */
);

extern int XFreeModifiermap(
    XModifierKeymap*	/* modmap */
);

extern int XFreePixmap(
    Display*		/* display */,
    Pixmap		/* pixmap */
);

extern int XGeometry(
    Display*		/* display */,
    int			/* screen */,
    const char*	/* position */,
    const char*	/* default_position */,
    unsigned int	/* bwidth */,
    unsigned int	/* fwidth */,
    unsigned int	/* fheight */,
    int			/* xadder */,
    int			/* yadder */,
    int*		/* x_return */,
    int*		/* y_return */,
    int*		/* width_return */,
    int*		/* height_return */
);

extern int XGetErrorDatabaseText(
    Display*		/* display */,
    const char*	/* name */,
    const char*	/* message */,
    const char*	/* default_string */,
    char*		/* buffer_return */,
    int			/* length */
);

extern int XGetErrorText(
    Display*		/* display */,
    int			/* code */,
    char*		/* buffer_return */,
    int			/* length */
);

extern Bool XGetFontProperty(
    XFontStruct*	/* font_struct */,
    Atom		/* atom */,
    unsigned long*	/* value_return */
);

extern Status XGetGCValues(
    Display*		/* display */,
    GC			/* gc */,
    unsigned long	/* valuemask */,
    XGCValues*		/* values_return */
);

extern Status XGetGeometry(
    Display*		/* display */,
    Drawable		/* d */,
    Window*		/* root_return */,
    int*		/* x_return */,
    int*		/* y_return */,
    unsigned int*	/* width_return */,
    unsigned int*	/* height_return */,
    unsigned int*	/* border_width_return */,
    unsigned int*	/* depth_return */
);

extern Status XGetIconName(
    Display*		/* display */,
    Window		/* w */,
    char**		/* icon_name_return */
);

extern int XGetInputFocus(
    Display*		/* display */,
    Window*		/* focus_return */,
    int*		/* revert_to_return */
);

extern int XGetKeyboardControl(
    Display*		/* display */,
    XKeyboardState*	/* values_return */
);

extern int XGetPointerControl(
    Display*		/* display */,
    int*		/* accel_numerator_return */,
    int*		/* accel_denominator_return */,
    int*		/* threshold_return */
);

extern int XGetPointerMapping(
    Display*		/* display */,
    unsigned char*	/* map_return */,
    int			/* nmap */
);

extern int XGetScreenSaver(
    Display*		/* display */,
    int*		/* timeout_return */,
    int*		/* interval_return */,
    int*		/* prefer_blanking_return */,
    int*		/* allow_exposures_return */
);

extern Status XGetTransientForHint(
    Display*		/* display */,
    Window		/* w */,
    Window*		/* prop_window_return */
);

extern int XGetWindowProperty(
    Display*		/* display */,
    Window		/* w */,
    Atom		/* property */,
    long		/* long_offset */,
    long		/* long_length */,
    Bool		/* delete */,
    Atom		/* req_type */,
    Atom*		/* actual_type_return */,
    int*		/* actual_format_return */,
    unsigned long*	/* nitems_return */,
    unsigned long*	/* bytes_after_return */,
    unsigned char**	/* prop_return */
);

extern Status XGetWindowAttributes(
    Display*		/* display */,
    Window		/* w */,
    XWindowAttributes*	/* window_attributes_return */
);

extern int XGrabButton(
    Display*		/* display */,
    unsigned int	/* button */,
    unsigned int	/* modifiers */,
    Window		/* grab_window */,
    Bool		/* owner_events */,
    unsigned int	/* event_mask */,
    int			/* pointer_mode */,
    int			/* keyboard_mode */,
    Window		/* confine_to */,
    Cursor		/* cursor */
);

extern int XGrabKey(
    Display*		/* display */,
    int			/* keycode */,
    unsigned int	/* modifiers */,
    Window		/* grab_window */,
    Bool		/* owner_events */,
    int			/* pointer_mode */,
    int			/* keyboard_mode */
);

extern int XGrabKeyboard(
    Display*		/* display */,
    Window		/* grab_window */,
    Bool		/* owner_events */,
    int			/* pointer_mode */,
    int			/* keyboard_mode */,
    Time		/* time */
);

extern int XGrabPointer(
    Display*		/* display */,
    Window		/* grab_window */,
    Bool		/* owner_events */,
    unsigned int	/* event_mask */,
    int			/* pointer_mode */,
    int			/* keyboard_mode */,
    Window		/* confine_to */,
    Cursor		/* cursor */,
    Time		/* time */
);

extern int XGrabServer(
    Display*		/* display */
);

extern int XHeightMMOfScreen(
    Screen*		/* screen */
);

extern int XHeightOfScreen(
    Screen*		/* screen */
);

extern int XIfEvent(
    Display*		/* display */,
    XEvent*		/* event_return */,
    Bool (*) (
	       Display*			/* display */,
               XEvent*			/* event */,
               XPointer			/* arg */
             )		/* predicate */,
    XPointer		/* arg */
);

extern int XImageByteOrder(
    Display*		/* display */
);

extern int XInstallColormap(
    Display*		/* display */,
    Colormap		/* colormap */
);

extern KeyCode XKeysymToKeycode(
    Display*		/* display */,
    KeySym		/* keysym */
);

extern int XKillClient(
    Display*		/* display */,
    XID			/* resource */
);

extern Status XLookupColor(
    Display*		/* display */,
    Colormap		/* colormap */,
    const char*	/* color_name */,
    XColor*		/* exact_def_return */,
    XColor*		/* screen_def_return */
);

extern int XLowerWindow(
    Display*		/* display */,
    Window		/* w */
);

extern int XMapRaised(
    Display*		/* display */,
    Window		/* w */
);

extern int XMapSubwindows(
    Display*		/* display */,
    Window		/* w */
);

extern int XMapWindow(
    Display*		/* display */,
    Window		/* w */
);

extern int XMaskEvent(
    Display*		/* display */,
    long		/* event_mask */,
    XEvent*		/* event_return */
);

extern int XMaxCmapsOfScreen(
    Screen*		/* screen */
);

extern int XMinCmapsOfScreen(
    Screen*		/* screen */
);

extern int XMoveResizeWindow(
    Display*		/* display */,
    Window		/* w */,
    int			/* x */,
    int			/* y */,
    unsigned int	/* width */,
    unsigned int	/* height */
);

extern int XMoveWindow(
    Display*		/* display */,
    Window		/* w */,
    int			/* x */,
    int			/* y */
);

extern int XNextEvent(
    Display*		/* display */,
    XEvent*		/* event_return */
);

extern int XNoOp(
    Display*		/* display */
);

extern Status XParseColor(
    Display*		/* display */,
    Colormap		/* colormap */,
    const char*	/* spec */,
    XColor*		/* exact_def_return */
);

extern int XParseGeometry(
    const char*	/* parsestring */,
    int*		/* x_return */,
    int*		/* y_return */,
    unsigned int*	/* width_return */,
    unsigned int*	/* height_return */
);

extern int XPeekEvent(
    Display*		/* display */,
    XEvent*		/* event_return */
);

extern int XPeekIfEvent(
    Display*		/* display */,
    XEvent*		/* event_return */,
    Bool (*) (
	       Display*		/* display */,
               XEvent*		/* event */,
               XPointer		/* arg */
             )		/* predicate */,
    XPointer		/* arg */
);

extern int XPending(
    Display*		/* display */
);

extern int XPlanesOfScreen(
    Screen*		/* screen */
);

extern int XProtocolRevision(
    Display*		/* display */
);

extern int XProtocolVersion(
    Display*		/* display */
);


extern int XPutBackEvent(
    Display*		/* display */,
    XEvent*		/* event */
);

extern int XPutImage(
    Display*		/* display */,
    Drawable		/* d */,
    GC			/* gc */,
    XImage*		/* image */,
    int			/* src_x */,
    int			/* src_y */,
    int			/* dest_x */,
    int			/* dest_y */,
    unsigned int	/* width */,
    unsigned int	/* height */	  
);

extern int XQLength(
    Display*		/* display */
);

extern Status XQueryBestCursor(
    Display*		/* display */,
    Drawable		/* d */,
    unsigned int        /* width */,
    unsigned int	/* height */,
    unsigned int*	/* width_return */,
    unsigned int*	/* height_return */
);

extern Status XQueryBestSize(
    Display*		/* display */,
    int			/* class */,
    Drawable		/* which_screen */,
    unsigned int	/* width */,
    unsigned int	/* height */,
    unsigned int*	/* width_return */,
    unsigned int*	/* height_return */
);

extern Status XQueryBestStipple(
    Display*		/* display */,
    Drawable		/* which_screen */,
    unsigned int	/* width */,
    unsigned int	/* height */,
    unsigned int*	/* width_return */,
    unsigned int*	/* height_return */
);

extern Status XQueryBestTile(
    Display*		/* display */,
    Drawable		/* which_screen */,
    unsigned int	/* width */,
    unsigned int	/* height */,
    unsigned int*	/* width_return */,
    unsigned int*	/* height_return */
);

extern int XQueryColor(
    Display*		/* display */,
    Colormap		/* colormap */,
    XColor*		/* def_in_out */
);

extern int XQueryColors(
    Display*		/* display */,
    Colormap		/* colormap */,
    XColor*		/* defs_in_out */,
    int			/* ncolors */
);

extern Bool XQueryExtension(
    Display*		/* display */,
    const char*	/* name */,
    int*		/* major_opcode_return */,
    int*		/* first_event_return */,
    int*		/* first_error_return */
);

extern int XQueryKeymap(
    Display*		/* display */,
    char [32]		/* keys_return */
);

extern Bool XQueryPointer(
    Display*		/* display */,
    Window		/* w */,
    Window*		/* root_return */,
    Window*		/* child_return */,
    int*		/* root_x_return */,
    int*		/* root_y_return */,
    int*		/* win_x_return */,
    int*		/* win_y_return */,
    unsigned int*       /* mask_return */
);

extern int XQueryTextExtents(
    Display*		/* display */,
    XID			/* font_ID */,
    const char*	/* string */,
    int			/* nchars */,
    int*		/* direction_return */,
    int*		/* font_ascent_return */,
    int*		/* font_descent_return */,
    XCharStruct*	/* overall_return */    
);

extern int XQueryTextExtents16(
    Display*		/* display */,
    XID			/* font_ID */,
    const XChar2b*	/* string */,
    int			/* nchars */,
    int*		/* direction_return */,
    int*		/* font_ascent_return */,
    int*		/* font_descent_return */,
    XCharStruct*	/* overall_return */
);

extern Status XQueryTree(
    Display*		/* display */,
    Window		/* w */,
    Window*		/* root_return */,
    Window*		/* parent_return */,
    Window**		/* children_return */,
    unsigned int*	/* nchildren_return */
);

extern int XRaiseWindow(
    Display*		/* display */,
    Window		/* w */
);

extern int XReadBitmapFile(
    Display*		/* display */,
    Drawable 		/* d */,
    const char*	/* filename */,
    unsigned int*	/* width_return */,
    unsigned int*	/* height_return */,
    Pixmap*		/* bitmap_return */,
    int*		/* x_hot_return */,
    int*		/* y_hot_return */
);

extern int XReadBitmapFileData(
    const char*	/* filename */,
    unsigned int*	/* width_return */,
    unsigned int*	/* height_return */,
    unsigned char**	/* data_return */,
    int*		/* x_hot_return */,
    int*		/* y_hot_return */
);

extern int XRebindKeysym(
    Display*		/* display */,
    KeySym		/* keysym */,
    KeySym*		/* list */,
    int			/* mod_count */,
    const unsigned char*	/* string */,
    int			/* bytes_string */
);

extern int XRecolorCursor(
    Display*		/* display */,
    Cursor		/* cursor */,
    XColor*		/* foreground_color */,
    XColor*		/* background_color */
);

extern int XRefreshKeyboardMapping(
    XMappingEvent*	/* event_map */    
);

extern int XRemoveFromSaveSet(
    Display*		/* display */,
    Window		/* w */
);

extern int XRemoveHost(
    Display*		/* display */,
    XHostAddress*	/* host */
);

extern int XRemoveHosts(
    Display*		/* display */,
    XHostAddress*	/* hosts */,
    int			/* num_hosts */
);

extern int XReparentWindow(
    Display*		/* display */,
    Window		/* w */,
    Window		/* parent */,
    int			/* x */,
    int			/* y */
);

extern int XResetScreenSaver(
    Display*		/* display */
);

extern int XResizeWindow(
    Display*		/* display */,
    Window		/* w */,
    unsigned int	/* width */,
    unsigned int	/* height */
);

extern int XRestackWindows(
    Display*		/* display */,
    Window*		/* windows */,
    int			/* nwindows */
);

extern int XRotateBuffers(
    Display*		/* display */,
    int			/* rotate */
);

extern int XRotateWindowProperties(
    Display*		/* display */,
    Window		/* w */,
    Atom*		/* properties */,
    int			/* num_prop */,
    int			/* npositions */
);

extern int XScreenCount(
    Display*		/* display */
);

extern int XSelectInput(
    Display*		/* display */,
    Window		/* w */,
    long		/* event_mask */
);

extern Status XSendEvent(
    Display*		/* display */,
    Window		/* w */,
    Bool		/* propagate */,
    long		/* event_mask */,
    XEvent*		/* event_send */
);

extern int XSetAccessControl(
    Display*		/* display */,
    int			/* mode */
);

extern int XSetArcMode(
    Display*		/* display */,
    GC			/* gc */,
    int			/* arc_mode */
);

extern int XSetBackground(
    Display*		/* display */,
    GC			/* gc */,
    unsigned long	/* background */
);

extern int XSetClipMask(
    Display*		/* display */,
    GC			/* gc */,
    Pixmap		/* pixmap */
);

extern int XSetClipOrigin(
    Display*		/* display */,
    GC			/* gc */,
    int			/* clip_x_origin */,
    int			/* clip_y_origin */
);

extern int XSetClipRectangles(
    Display*		/* display */,
    GC			/* gc */,
    int			/* clip_x_origin */,
    int			/* clip_y_origin */,
    XRectangle*		/* rectangles */,
    int			/* n */,
    int			/* ordering */
);

extern int XSetCloseDownMode(
    Display*		/* display */,
    int			/* close_mode */
);

extern int XSetCommand(
    Display*		/* display */,
    Window		/* w */,
    char**		/* argv */,
    int			/* argc */
);

extern int XSetDashes(
    Display*		/* display */,
    GC			/* gc */,
    int			/* dash_offset */,
    const char*	/* dash_list */,
    int			/* n */
);

extern int XSetFillRule(
    Display*		/* display */,
    GC			/* gc */,
    int			/* fill_rule */
);

extern int XSetFillStyle(
    Display*		/* display */,
    GC			/* gc */,
    int			/* fill_style */
);

extern int XSetFont(
    Display*		/* display */,
    GC			/* gc */,
    Font		/* font */
);

extern int XSetFontPath(
    Display*		/* display */,
    char**		/* directories */,
    int			/* ndirs */	     
);

extern int XSetForeground(
    Display*		/* display */,
    GC			/* gc */,
    unsigned long	/* foreground */
);

extern int XSetFunction(
    Display*		/* display */,
    GC			/* gc */,
    int			/* function */
);

extern int XSetGraphicsExposures(
    Display*		/* display */,
    GC			/* gc */,
    Bool		/* graphics_exposures */
);

extern int XSetIconName(
    Display*		/* display */,
    Window		/* w */,
    const char*	/* icon_name */
);

extern int XSetInputFocus(
    Display*		/* display */,
    Window		/* focus */,
    int			/* revert_to */,
    Time		/* time */
);

extern int XSetLineAttributes(
    Display*		/* display */,
    GC			/* gc */,
    unsigned int	/* line_width */,
    int			/* line_style */,
    int			/* cap_style */,
    int			/* join_style */
);

extern int XSetModifierMapping(
    Display*		/* display */,
    XModifierKeymap*	/* modmap */
);

extern int XSetPlaneMask(
    Display*		/* display */,
    GC			/* gc */,
    unsigned long	/* plane_mask */
);

extern int XSetPointerMapping(
    Display*		/* display */,
    const unsigned char*	/* map */,
    int			/* nmap */
);

extern int XSetScreenSaver(
    Display*		/* display */,
    int			/* timeout */,
    int			/* interval */,
    int			/* prefer_blanking */,
    int			/* allow_exposures */
);

extern int XSetSelectionOwner(
    Display*		/* display */,
    Atom	        /* selection */,
    Window		/* owner */,
    Time		/* time */
);

extern int XSetState(
    Display*		/* display */,
    GC			/* gc */,
    unsigned long 	/* foreground */,
    unsigned long	/* background */,
    int			/* function */,
    unsigned long	/* plane_mask */
);

extern int XSetStipple(
    Display*		/* display */,
    GC			/* gc */,
    Pixmap		/* stipple */
);

extern int XSetSubwindowMode(
    Display*		/* display */,
    GC			/* gc */,
    int			/* subwindow_mode */
);

extern int XSetTSOrigin(
    Display*		/* display */,
    GC			/* gc */,
    int			/* ts_x_origin */,
    int			/* ts_y_origin */
);

extern int XSetTile(
    Display*		/* display */,
    GC			/* gc */,
    Pixmap		/* tile */
);

extern int XSetWindowBackground(
    Display*		/* display */,
    Window		/* w */,
    unsigned long	/* background_pixel */
);

extern int XSetWindowBackgroundPixmap(
    Display*		/* display */,
    Window		/* w */,
    Pixmap		/* background_pixmap */
);

extern int XSetWindowBorder(
    Display*		/* display */,
    Window		/* w */,
    unsigned long	/* border_pixel */
);

extern int XSetWindowBorderPixmap(
    Display*		/* display */,
    Window		/* w */,
    Pixmap		/* border_pixmap */
);

extern int XSetWindowBorderWidth(
    Display*		/* display */,
    Window		/* w */,
    unsigned int	/* width */
);

extern int XSetWindowColormap(
    Display*		/* display */,
    Window		/* w */,
    Colormap		/* colormap */
);

extern int XStoreBuffer(
    Display*		/* display */,
    const char*	/* bytes */,
    int			/* nbytes */,
    int			/* buffer */
);

extern int XStoreBytes(
    Display*		/* display */,
    const char*	/* bytes */,
    int			/* nbytes */
);

extern int XStoreColor(
    Display*		/* display */,
    Colormap		/* colormap */,
    XColor*		/* color */
);

extern int XStoreColors(
    Display*		/* display */,
    Colormap		/* colormap */,
    XColor*		/* color */,
    int			/* ncolors */
);

extern int XStoreName(
    Display*		/* display */,
    Window		/* w */,
    const char*	/* window_name */
);

extern int XStoreNamedColor(
    Display*		/* display */,
    Colormap		/* colormap */,
    const char*	/* color */,
    unsigned long	/* pixel */,
    int			/* flags */
);

extern int XSync(
    Display*		/* display */,
    Bool		/* discard */
);

extern int XTextExtents(
    XFontStruct*	/* font_struct */,
    const char*	/* string */,
    int			/* nchars */,
    int*		/* direction_return */,
    int*		/* font_ascent_return */,
    int*		/* font_descent_return */,
    XCharStruct*	/* overall_return */
);

extern int XTextExtents16(
    XFontStruct*	/* font_struct */,
    const XChar2b*	/* string */,
    int			/* nchars */,
    int*		/* direction_return */,
    int*		/* font_ascent_return */,
    int*		/* font_descent_return */,
    XCharStruct*	/* overall_return */
);

extern int XTextWidth(
    XFontStruct*	/* font_struct */,
    const char*	/* string */,
    int			/* count */
);

extern int XTextWidth16(
    XFontStruct*	/* font_struct */,
    const XChar2b*	/* string */,
    int			/* count */
);

extern Bool XTranslateCoordinates(
    Display*		/* display */,
    Window		/* src_w */,
    Window		/* dest_w */,
    int			/* src_x */,
    int			/* src_y */,
    int*		/* dest_x_return */,
    int*		/* dest_y_return */,
    Window*		/* child_return */
);

extern int XUndefineCursor(
    Display*		/* display */,
    Window		/* w */
);

extern int XUngrabButton(
    Display*		/* display */,
    unsigned int	/* button */,
    unsigned int	/* modifiers */,
    Window		/* grab_window */
);

extern int XUngrabKey(
    Display*		/* display */,
    int			/* keycode */,
    unsigned int	/* modifiers */,
    Window		/* grab_window */
);

extern int XUngrabKeyboard(
    Display*		/* display */,
    Time		/* time */
);

extern int XUngrabPointer(
    Display*		/* display */,
    Time		/* time */
);

extern int XUngrabServer(
    Display*		/* display */
);

extern int XUninstallColormap(
    Display*		/* display */,
    Colormap		/* colormap */
);

extern int XUnloadFont(
    Display*		/* display */,
    Font		/* font */
);

extern int XUnmapSubwindows(
    Display*		/* display */,
    Window		/* w */
);

extern int XUnmapWindow(
    Display*		/* display */,
    Window		/* w */
);

extern int XVendorRelease(
    Display*		/* display */
);

extern int XWarpPointer(
    Display*		/* display */,
    Window		/* src_w */,
    Window		/* dest_w */,
    int			/* src_x */,
    int			/* src_y */,
    unsigned int	/* src_width */,
    unsigned int	/* src_height */,
    int			/* dest_x */,
    int			/* dest_y */	     
);

extern int XWidthMMOfScreen(
    Screen*		/* screen */
);

extern int XWidthOfScreen(
    Screen*		/* screen */
);

extern int XWindowEvent(
    Display*		/* display */,
    Window		/* w */,
    long		/* event_mask */,
    XEvent*		/* event_return */
);

extern int XWriteBitmapFile(
    Display*		/* display */,
    const char*	/* filename */,
    Pixmap		/* bitmap */,
    unsigned int	/* width */,
    unsigned int	/* height */,
    int			/* x_hot */,
    int			/* y_hot */		     
);

extern Bool XSupportsLocale (void);

extern char *XSetLocaleModifiers(
    const char*		/* modifier_list */
);

extern XOM XOpenOM(
    Display*			/* display */,
    struct _XrmHashBucketRec*	/* rdb */,
    const char*		/* res_name */,
    const char*		/* res_class */
);

extern Status XCloseOM(
    XOM			/* om */
);

extern char *XSetOMValues(
    XOM			/* om */,
    ...
);

extern char *XGetOMValues(
    XOM			/* om */,
    ...
);

extern Display *XDisplayOfOM(
    XOM			/* om */
);

extern char *XLocaleOfOM(
    XOM			/* om */
);

extern XOC XCreateOC(
    XOM			/* om */,
    ...
);

extern void XDestroyOC(
    XOC			/* oc */
);

extern XOM XOMOfOC(
    XOC			/* oc */
);

extern char *XSetOCValues(
    XOC			/* oc */,
    ...
);

extern char *XGetOCValues(
    XOC			/* oc */,
    ...
);

extern XFontSet XCreateFontSet(
    Display*		/* display */,
    const char*	/* base_font_name_list */,
    char***		/* missing_charset_list */,
    int*		/* missing_charset_count */,
    char**		/* def_string */
);

extern void XFreeFontSet(
    Display*		/* display */,
    XFontSet		/* font_set */
);

extern int XFontsOfFontSet(
    XFontSet		/* font_set */,
    XFontStruct***	/* font_struct_list */,
    char***		/* font_name_list */
);

extern char *XBaseFontNameListOfFontSet(
    XFontSet		/* font_set */
);

extern char *XLocaleOfFontSet(
    XFontSet		/* font_set */
);

extern Bool XContextDependentDrawing(
    XFontSet		/* font_set */
);

extern Bool XDirectionalDependentDrawing(
    XFontSet		/* font_set */
);

extern Bool XContextualDrawing(
    XFontSet		/* font_set */
);

extern XFontSetExtents *XExtentsOfFontSet(
    XFontSet		/* font_set */
);

extern int XmbTextEscapement(
    XFontSet		/* font_set */,
    const char*	/* text */,
    int			/* bytes_text */
);

extern int XwcTextEscapement(
    XFontSet		/* font_set */,
    const wchar_t*	/* text */,
    int			/* num_wchars */
);

extern int XmbTextExtents(
    XFontSet		/* font_set */,
    const char*	/* text */,
    int			/* bytes_text */,
    XRectangle*		/* overall_ink_return */,
    XRectangle*		/* overall_logical_return */
);

extern int XwcTextExtents(
    XFontSet		/* font_set */,
    const wchar_t*	/* text */,
    int			/* num_wchars */,
    XRectangle*		/* overall_ink_return */,
    XRectangle*		/* overall_logical_return */
);

extern Status XmbTextPerCharExtents(
    XFontSet		/* font_set */,
    const char*	/* text */,
    int			/* bytes_text */,
    XRectangle*		/* ink_extents_buffer */,
    XRectangle*		/* logical_extents_buffer */,
    int			/* buffer_size */,
    int*		/* num_chars */,
    XRectangle*		/* overall_ink_return */,
    XRectangle*		/* overall_logical_return */
);

extern Status XwcTextPerCharExtents(
    XFontSet		/* font_set */,
    const wchar_t*	/* text */,
    int			/* num_wchars */,
    XRectangle*		/* ink_extents_buffer */,
    XRectangle*		/* logical_extents_buffer */,
    int			/* buffer_size */,
    int*		/* num_chars */,
    XRectangle*		/* overall_ink_return */,
    XRectangle*		/* overall_logical_return */
);


extern void XmbDrawText(
    Display*		/* display */,
    Drawable		/* d */,
    GC			/* gc */,
    int			/* x */,
    int			/* y */,
    XmbTextItem*	/* text_items */,
    int			/* nitems */
);

extern void XwcDrawText(
    Display*		/* display */,
    Drawable		/* d */,
    GC			/* gc */,
    int			/* x */,
    int			/* y */,
    XwcTextItem*	/* text_items */,
    int			/* nitems */
);

extern void XmbDrawString(
    Display*		/* display */,
    Drawable		/* d */,
    XFontSet		/* font_set */,
    GC			/* gc */,
    int			/* x */,
    int			/* y */,
    const char*	/* text */,
    int			/* bytes_text */
);

extern void XwcDrawString(
    Display*		/* display */,
    Drawable		/* d */,
    XFontSet		/* font_set */,
    GC			/* gc */,
    int			/* x */,
    int			/* y */,
    const wchar_t*	/* text */,
    int			/* num_wchars */
);

extern void XmbDrawImageString(
    Display*		/* display */,
    Drawable		/* d */,
    XFontSet		/* font_set */,
    GC			/* gc */,
    int			/* x */,
    int			/* y */,
    const char*	/* text */,
    int			/* bytes_text */
);

extern void XwcDrawImageString(
    Display*		/* display */,
    Drawable		/* d */,
    XFontSet		/* font_set */,
    GC			/* gc */,
    int			/* x */,
    int			/* y */,
    const wchar_t*	/* text */,
    int			/* num_wchars */
);

extern XIM XOpenIM(
    Display*			/* dpy */,
    struct _XrmHashBucketRec*	/* rdb */,
    char*			/* res_name */,
    char*			/* res_class */
);

extern Status XCloseIM(
    XIM /* im */
);

extern char *XGetIMValues(
    XIM /* im */, ...
);

extern char *XSetIMValues(
    XIM /* im */, ...
);

extern Display *XDisplayOfIM(
    XIM /* im */
);

extern char *XLocaleOfIM(
    XIM /* im*/
);

extern XIC XCreateIC(
    XIM /* im */, ...
);

extern void XDestroyIC(
    XIC /* ic */
);

extern void XSetICFocus(
    XIC /* ic */
);

extern void XUnsetICFocus(
    XIC /* ic */
);

extern wchar_t *XwcResetIC(
    XIC /* ic */
);

extern char *XmbResetIC(
    XIC /* ic */
);

extern char *XSetICValues(
    XIC /* ic */, ...
);

extern char *XGetICValues(
    XIC /* ic */, ...
);

extern XIM XIMOfIC(
    XIC /* ic */
);

extern Bool XFilterEvent(
    XEvent*	/* event */,
    Window	/* window */
);

extern int XmbLookupString(
    XIC			/* ic */,
    XKeyPressedEvent*	/* event */,
    char*		/* buffer_return */,
    int			/* bytes_buffer */,
    KeySym*		/* keysym_return */,
    Status*		/* status_return */
);

extern int XwcLookupString(
    XIC			/* ic */,
    XKeyPressedEvent*	/* event */,
    wchar_t*		/* buffer_return */,
    int			/* wchars_buffer */,
    KeySym*		/* keysym_return */,
    Status*		/* status_return */
);

extern XVaNestedList XVaCreateNestedList(
    int /*unused*/, ...
);

/* internal connections for IMs */

extern Bool XRegisterIMInstantiateCallback(
    Display*			/* dpy */,
    struct _XrmHashBucketRec*	/* rdb */,
    char*			/* res_name */,
    char*			/* res_class */,
    XIMProc			/* callback */,
    XPointer*			/* client_data */
);

extern Bool XUnregisterIMInstantiateCallback(
    Display*			/* dpy */,
    struct _XrmHashBucketRec*	/* rdb */,
    char*			/* res_name */,
    char*			/* res_class */,
    XIMProc			/* callback */,
    XPointer*			/* client_data */
);

extern Status XInternalConnectionNumbers(
    Display*			/* dpy */,
    int**			/* fd_return */,
    int*			/* count_return */
);

extern void XProcessInternalConnection(
    Display*			/* dpy */,
    int				/* fd */
);

extern Status XAddConnectionWatch(
    Display*			/* dpy */,
    XConnectionWatchProc	/* callback */,
    XPointer			/* client_data */
);

extern void XRemoveConnectionWatch(
    Display*			/* dpy */,
    XConnectionWatchProc	/* callback */,
    XPointer			/* client_data */
);

