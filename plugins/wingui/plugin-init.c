/* 
   Copyright (c) 2007 Luca Bruno

   This file is part of Smalltalk YX.

   Permission is hereby granted, free of charge, to any person obtaining a copy
   of this software and associated documentation files (the "Software"), to deal
   in the Software without restriction, including without limitation the rights
   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell   
   copies of the Software, and to permit persons to whom the Software is
   furnished to do so, subject to the following conditions:
   
   The above copyright notice and this permission notice shall be included in
   all copies or substantial portions of the Software.
   
   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,  
   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
   FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER    
   DEALINGS IN THE SOFTWARE.
*/

#include <syx/syx.h>

#include <stdio.h>
#include <windows.h>
#include <winbase.h>
#include <winuser.h>
#include <windowsx.h>
#include <commctrl.h>

#define ID_BTN_DOIT 301
#define ID_BTN_CLEAR 302
#define ID_BTN_EXIT 303

LRESULT CALLBACK WndProcedure(HWND, UINT, WPARAM, LPARAM);

static HINSTANCE hInstance;
static HWND hwndEdit;

LRESULT CALLBACK WndProcedure(HWND hWnd, UINT Msg, WPARAM wParam, LPARAM lParam)
{
  static HWND hwndDoIt;
  static HWND hwndClear;
  static HWND hwndExit;
  
  switch (Msg) {
  case WM_CREATE:
    hwndEdit = CreateWindow(SYX_IFDEF_UNICODE ("EDIT"),
			    NULL,
			    WS_CHILD | WS_VISIBLE | WS_HSCROLL |
			    WS_VSCROLL | ES_LEFT | ES_MULTILINE |
			    ES_AUTOHSCROLL | ES_AUTOVSCROLL,
			    0, 0, 0, 0,
			    hWnd,
			    0,
			    hInstance,
			    NULL);
    if (!hwndEdit)
      {
	MessageBox(0, SYX_IFDEF_UNICODE ("Could not create workspace"),
		   SYX_IFDEF_UNICODE ("Error"), 0);
	exit(1);
      }
    Edit_SetText (hwndEdit, SYX_IFDEF_UNICODE ("'Hello PocketPC' printNl"));

    hwndDoIt = CreateWindow(SYX_IFDEF_UNICODE ("BUTTON"),
			    NULL,
			    WS_CHILD | WS_VISIBLE | ES_LEFT,
			    0, 0, 0, 0,
			    hWnd,
			    (HMENU) ID_BTN_DOIT,
			    hInstance,
			    NULL);
    if (!hwndDoIt)
      {
	MessageBox(0, SYX_IFDEF_UNICODE ("Could not create button"), SYX_IFDEF_UNICODE ("Error"), 0);
	exit(1);
      }
    Button_SetText (hwndDoIt, SYX_IFDEF_UNICODE ("&DoIt"));

    hwndClear = CreateWindow(SYX_IFDEF_UNICODE ("BUTTON"),
			     NULL,
			     WS_CHILD | WS_VISIBLE | ES_LEFT,
			     0, 0, 0, 0,
			     hWnd,
			     (HMENU) ID_BTN_CLEAR,
			     hInstance,
			     NULL);
    if (!hwndClear)
      {
	MessageBox(0, SYX_IFDEF_UNICODE ("Could not create button"), SYX_IFDEF_UNICODE ("Error"), 0);
	exit(1);
      }
    Button_SetText (hwndClear, SYX_IFDEF_UNICODE ("&Clear"));

    hwndExit = CreateWindow(SYX_IFDEF_UNICODE ("BUTTON"),
			    NULL,
			    WS_CHILD | WS_VISIBLE | ES_LEFT,
			    0, 0, 0, 0,
			    hWnd,
			    (HMENU) ID_BTN_EXIT,
			    hInstance,
			    NULL);
    if (!hwndExit)
      {
	MessageBox(0, SYX_IFDEF_UNICODE ("Could not create button"), SYX_IFDEF_UNICODE ("Error"), 0);
	exit(1);
      }
    Button_SetText (hwndExit, SYX_IFDEF_UNICODE ("E&xit"));
    break;
  case WM_SIZE:
    MoveWindow(hwndEdit, 1, 21, LOWORD(lParam)+1, HIWORD(lParam) - 21, TRUE);
    MoveWindow(hwndDoIt, 1, 0, 50, 20, TRUE);
    MoveWindow(hwndClear, 60, 0, 50, 20, TRUE);
    MoveWindow(hwndExit, LOWORD(lParam)-50, 0, 50, 20, TRUE);
    break;
  case WM_DESTROY:
    exit (0);
    break;
  case WM_COMMAND:
    switch (LOWORD(wParam))
      {
      case ID_BTN_DOIT:
	{
	  syx_size length = Edit_GetTextLength (hwndEdit) + 1;
	  SYX_IFDEF_CHAR_T *text = syx_calloc (length + 1, sizeof (SYX_IFDEF_CHAR_T));
	  Edit_GetText (hwndEdit, text, length);
	  text[length] = '\0';
	  SyxOop stext = syx_string_new (SYX_IFDEF_ANSI (text));
	  syx_free (text);
	  /* Pop out from the stack the true object previously pushed
	     by WinGui_IterateLoop. We'll enter another context, which will return
	     another object (push the object into the stack of this context).
	     The true object is in other words the default object returned by the
	     loop iteration, but now we let the new context push its object without growing
	     the stack versus infinite.
	  */
	  syx_interp_stack_pop ();
	  syx_interp_enter_context (syx_send_binary_message (syx_interp_get_current_process (),
                                                             syx_interp_get_current_context (),
							     syx_globals_at ("WinWorkspace"),
							     "doIt:",
							     stext));
	}
	break;
      case ID_BTN_CLEAR:
	Edit_SetText (hwndEdit, "");
	break;
      case ID_BTN_EXIT:
	exit (0);
	break;
      }
  default:
    return DefWindowProcW(hWnd, Msg, wParam, lParam);
  }
  return 0;
}


syx_bool
syx_plugin_initialize (void)
{
  HWND hWnd;

  const SYX_IFDEF_CHAR_T *ClsName = SYX_IFDEF_UNICODE ("SmalltalkYX");

  hInstance = GetModuleHandle (NULL);
  if (!hInstance)
    {
      MessageBox (0, SYX_IFDEF_UNICODE ("Could not get module handle"), SYX_IFDEF_UNICODE ("Error"), 0);
      exit (1);
    }

#ifndef WINCE
  WNDCLASS WndCls;
  WndCls.style		= CS_DBLCLKS | CS_HREDRAW | CS_VREDRAW;
  WndCls.lpfnWndProc	= WndProcedure;
  WndCls.cbClsExtra	= 0;
  WndCls.cbWndExtra	= 0;
  WndCls.hCursor = LoadCursor (NULL, IDC_ARROW);
  WndCls.hIcon = NULL;
  WndCls.hCursor = NULL;
  WndCls.lpszMenuName	= NULL;
  WndCls.lpszClassName	= ClsName;
  WndCls.hInstance	= hInstance;
  WndCls.hbrBackground = (HBRUSH) COLOR_BACKGROUND;
#else /* WINCE */
  WNDCLASS WndCls;
  WndCls.style		= CS_HREDRAW | CS_VREDRAW;
  WndCls.lpfnWndProc	= WndProcedure;
  WndCls.cbClsExtra	= 0;
  WndCls.cbWndExtra	= 0;
  WndCls.hIcon		= NULL;
  WndCls.hCursor		= NULL;
  WndCls.hbrBackground	= (HBRUSH)GetStockObject(WHITE_BRUSH);
  WndCls.lpszMenuName	= NULL;
  WndCls.lpszClassName	= ClsName;
  WndCls.hInstance	= hInstance;
#endif

  if (!RegisterClass(&WndCls))
    {
      MessageBox (0, SYX_IFDEF_UNICODE ("Could not register window class"), SYX_IFDEF_UNICODE ("Error"), 0);
      exit (1);
    }
  
  // CreateWindowA doesn't work with ANSI window name?
  hWnd = CreateWindow(ClsName, L"Smalltalk YX 0.1.4", WS_OVERLAPPEDWINDOW,
		      0, 0,
		      CW_USEDEFAULT, CW_USEDEFAULT,
		      NULL, NULL,
		      hInstance,
		      NULL);
  if (!hWnd)
    {
      MessageBox (0, SYX_IFDEF_UNICODE ("Could not create window"), SYX_IFDEF_UNICODE ("Error"), 0);
      exit (1);
    }
  
  ShowWindow(hWnd, SW_SHOWNORMAL);
  UpdateWindow(hWnd);

  return TRUE;
}

SYX_FUNC_PRIMITIVE (WinGui_IterateLoop)
{
  MSG Msg;
  if (!GetMessage (&Msg, NULL, 0, 0))
    {
      SYX_PRIM_RETURN (syx_false);
    }

  /* SYX_PRIM_RETURN will push an object then return.
     Here we push true, dispatch the Windows message and return */
  syx_interp_stack_push (syx_true);
  TranslateMessage (&Msg);
  DispatchMessage (&Msg);
  return TRUE;
}

SYX_FUNC_PRIMITIVE (WinGui_TranscriptNextPutAll)
{
  SYX_PRIM_ARGS(1);
  syx_symbol otext = SYX_OBJECT_SYMBOL(es->message_arguments[0]);
  syx_size curlength = Edit_GetTextLength (hwndEdit) + 1;
  syx_size length = curlength + strlen (otext);
  SYX_IFDEF_CHAR_T *text = syx_calloc (length + 1, sizeof (SYX_IFDEF_CHAR_T));
  Edit_GetText (hwndEdit, text, curlength);
#ifdef UNICODE
  wcscat (text, SYX_IFDEF_UNICODE (otext));
#else
  strcat (text, otext);
#endif
  Edit_SetText (hwndEdit, text);
  syx_free (text);
  SYX_PRIM_RETURN (es->message_arguments[0]);
}

void
syx_plugin_finalize (void)
{
  
}
