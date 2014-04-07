#include <stdio.h>
#include <pthread.h>
#include <stdint.h>
#include <time.h>
#include <assert.h>


typedef _Atomic(int) atomic_int;

#define MAXI 1E9
#define load_relaxed(x) __c11_atomic_load(&x, __ATOMIC_RELAXED)

#ifdef MM_ACQ_REL
        #define MM "ACQ_REL"
        #define load(x) __c11_atomic_load(&x, __ATOMIC_ACQUIRE)
        #define store(x,y) __c11_atomic_store(&x, y, __ATOMIC_RELEASE)
#elif defined MM_SEQ_CST
        #define MM "SEQ_CST"
        #define load(x) __c11_atomic_load(&x, __ATOMIC_SEQ_CST)
        #define store(x,y) __c11_atomic_store(&x, y, __ATOMIC_SEQ_CST)
#else
        #define MM "ATOM"
        #define load(x) x
        #define store(x,y) x=y
#endif

#define true 1
#define false 0
#define SLEEPTIME (struct timespec[]) {{0, 50*1000*1000}}

atomic_int lock=0, x1=0, x2=0;

void writer() {
    int i, local_lock=0;
    for (i=1; i<=MAXI; i++) {
        store(lock, ++local_lock);
        store(x1, i);
        store(x2, i);
        store(lock, ++local_lock);
    }
}

void reader() {
    int v1=0, v2=0, i=0, ii;
    while (v1 < MAXI - 1) {
        i++;
        int lv1, lv2, local_lock;
        while (true) {
            local_lock = load(lock);
            if (local_lock & 1) continue;
            v1 = load(x1);
            v2 = load(x2);
            if (local_lock == load(lock)) {
                break;
            }
        }
        assert(v1 == v2);
        nanosleep(SLEEPTIME, NULL);
    }
    printf("done!!!");
}

void *prod(void* data) {
    writer();
    return 0;
}

void *cons(void* data) {
    reader();
    return 0;
}

int main(void) {
    pthread_t p;
    pthread_t c;

    pthread_attr_t attr;
    pthread_attr_init(&attr);
    pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_JOINABLE); 

    pthread_create(&p, &attr, prod, NULL);
    pthread_create(&c, &attr, cons, NULL);
    pthread_join(p, NULL);
    pthread_join(c, NULL);
    return 0;
}
