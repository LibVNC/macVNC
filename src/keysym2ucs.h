#ifndef MACVNC_KEYSYM2UCS_H
#define MACVNC_KEYSYM2UCS_H

#include <stdint.h>

/*
 * Convert an X11 keysym to the corresponding Unicode (UTF-32) code point.
 * Returns -1 if the keysym has no Unicode counterpart.
 *
 * Based on keysym2ucs.c by Markus G. Kuhn (public domain),
 * https://www.cl.cam.ac.uk/~mgk25/ucs/keysym2ucs.c
 */
long keysym2ucs(uint32_t keysym);

#endif
