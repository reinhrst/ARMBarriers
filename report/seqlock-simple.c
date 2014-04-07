atomic int lock=0, x1=0, x2=0;

void write(int v1, int v2) {
    int local_lock = load_relaxed(lock);
    store(lock, ++local_lock);
    store(x1, v1);
    store(x2, v2);
    store(lock, ++local_lock);
}

void read(int *v1, int *v2) {
    int lv1, lv2, local_lock;
    while (true) {
        local_lock = load(lock);
        if (local_lock & 1) continue;
        lv1 = load(x1);
        lv2 = load(x2);
        if (local_lock == load(lock)) {
            *v1 = lv1;
            *v2 = lv2;
            return;
        }
    }
}
