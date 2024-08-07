#ifndef ALT_FUNCTIONS_H
#define ALT_FUNCTIONS_H

#if defined(__osf__) || defined(_hpux) || defined(_AIX) || defined(__sgi) || defined(__APPLE__)
#define strsinal(sig) ALT_strsignal(sig)
#endif
char *ALT_strsignal(int sig);

#if defined(__hpux) || defined(__osf__)
#define hstrerror(err) ALT_hstrerror(err)
#endif
char *ALT_hstrerror(int sig);

#if defined(__hpux) || defined(__osf__)
#define posix_openpt(flags) ALT_posix_openpt(flags)
#endif
int ALT_posix_openpt(int flags);

#endif //ALT_FUNCTIONS_H
