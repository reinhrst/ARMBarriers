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
}
