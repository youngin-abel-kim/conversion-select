#include <Windows.h>
#include <cstdlib>
#include <cstdio>

#define GET_CONVERSION_STATUS 0x0001
#define SET_CONVERSION_STATUS 0x0002

int main(int argc, char** argv)
{
	HWND hIME = ImmGetDefaultIMEWnd(GetForegroundWindow());

	if (argc == 1) {
		LRESULT status = SendMessage(hIME, WM_IME_CONTROL, GET_CONVERSION_STATUS, 0);
		printf("%lld\n", static_cast<long long>(status));
	}
	else {
		SendMessage(hIME, WM_IME_CONTROL, SET_CONVERSION_STATUS, atoi(argv[1]));
	}

	return 0;
}
