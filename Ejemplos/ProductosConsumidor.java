import java.util.LinkedList;
import java.util.Queue;
import java.util.concurrent.Semaphore;

/**
 * Problema Productor-Consumidor con Semáforos en Java
 *
 * Semáforos utilizados:
 *  - vacio  : cuenta los espacios libres en el buffer (init = CAPACIDAD)
 *  - lleno  : cuenta los items disponibles para consumir (init = 0)
 *  - mutex  : garantiza exclusión mutua al acceder al buffer (init = 1)
 *
 * Productor:
 *   vacio.acquire()  → espera si no hay espacio
 *   mutex.acquire()  → entra a sección crítica
 *   buffer.add()     → inserta item
 *   mutex.release()  → sale de sección crítica
 *   lleno.release()  → señaliza que hay un item nuevo
 *
 * Consumidor:
 *   lleno.acquire()  → espera si no hay items
 *   mutex.acquire()  → entra a sección crítica
 *   buffer.poll()    → retira item
 *   mutex.release()  → sale de sección crítica
 *   vacio.release()  → señaliza que hay un espacio libre
 */
public class ProductorConsumidor {

    // ─── Capacidad del buffer compartido ────────────────────────────────────
    private static final int CAPACIDAD = 5;

    // ─── Buffer compartido ───────────────────────────────────────────────────
    private static final Queue<Integer> buffer = new LinkedList<>();

    // ─── Semáforos ───────────────────────────────────────────────────────────
    private static final Semaphore vacio = new Semaphore(CAPACIDAD); // espacios libres
    private static final Semaphore lleno = new Semaphore(0);         // items disponibles
    private static final Semaphore mutex = new Semaphore(1);         // exclusión mutua

    // ════════════════════════════════════════════════════════════════════════
    //  HILO PRODUCTOR
    // ════════════════════════════════════════════════════════════════════════
    static class Productor extends Thread {
        private final int id;
        private final int totalItems;

        public Productor(int id, int totalItems) {
            this.id = id;
            this.totalItems = totalItems;
        }

        @Override
        public void run() {
            for (int i = 1; i <= totalItems; i++) {
                try {
                    int item = id * 100 + i; // item único por productor

                    // ── Simula tiempo de producción ──────────────────────
                    Thread.sleep((long) (Math.random() * 500 + 100));

                    // ── ACQUIRE vacio: espera si no hay espacio en buffer
                    vacio.acquire();
                    System.out.printf("[Productor %d] acquire(vacio) → permisos restantes: %d%n",
                            id, vacio.availablePermits());

                    // ── ACQUIRE mutex: entra a sección crítica ───────────
                    mutex.acquire();
                    System.out.printf("[Productor %d] acquire(mutex) → sección crítica ABIERTA%n", id);

                    // ── Sección crítica: insertar en buffer ──────────────
                    buffer.add(item);
                    System.out.printf("[Productor %d] PRODUJO item=%d | buffer=%s%n",
                            id, item, buffer);

                    // ── RELEASE mutex: sale de sección crítica ───────────
                    mutex.release();
                    System.out.printf("[Productor %d] release(mutex) → sección crítica CERRADA%n", id);

                    // ── RELEASE lleno: señaliza item disponible ───────────
                    lleno.release();
                    System.out.printf("[Productor %d] release(lleno) → permisos: %d%n%n",
                            id, lleno.availablePermits());

                } catch (InterruptedException e) {
                    Thread.currentThread().interrupt();
                    System.err.println("[Productor " + id + "] Interrumpido");
                }
            }
            System.out.printf("✔ Productor %d terminó.%n", id);
        }
    }

    // ════════════════════════════════════════════════════════════════════════
    //  HILO CONSUMIDOR
    // ════════════════════════════════════════════════════════════════════════
    static class Consumidor extends Thread {
        private final int id;
        private final int totalItems;

        public Consumidor(int id, int totalItems) {
            this.id = id;
            this.totalItems = totalItems;
        }

        @Override
        public void run() {
            for (int i = 1; i <= totalItems; i++) {
                try {
                    // ── ACQUIRE lleno: espera si no hay items en buffer ──
                    lleno.acquire();
                    System.out.printf("[Consumidor %d] acquire(lleno) → permisos restantes: %d%n",
                            id, lleno.availablePermits());

                    // ── ACQUIRE mutex: entra a sección crítica ───────────
                    mutex.acquire();
                    System.out.printf("[Consumidor %d] acquire(mutex) → sección crítica ABIERTA%n", id);

                    // ── Sección crítica: retirar del buffer ──────────────
                    int item = buffer.poll();
                    System.out.printf("[Consumidor %d] CONSUMIÓ item=%d | buffer=%s%n",
                            id, item, buffer);

                    // ── RELEASE mutex: sale de sección crítica ───────────
                    mutex.release();
                    System.out.printf("[Consumidor %d] release(mutex) → sección crítica CERRADA%n", id);

                    // ── RELEASE vacio: señaliza espacio libre ─────────────
                    vacio.release();
                    System.out.printf("[Consumidor %d] release(vacio) → permisos: %d%n%n",
                            id, vacio.availablePermits());

                    // ── Simula tiempo de procesamiento ───────────────────
                    Thread.sleep((long) (Math.random() * 700 + 200));

                } catch (InterruptedException e) {
                    Thread.currentThread().interrupt();
                    System.err.println("[Consumidor " + id + "] Interrumpido");
                }
            }
            System.out.printf("✔ Consumidor %d terminó.%n", id);
        }
    }

    // ════════════════════════════════════════════════════════════════════════
    //  MAIN
    // ════════════════════════════════════════════════════════════════════════
    public static void main(String[] args) throws InterruptedException {
        final int ITEMS_POR_PRODUCTOR = 4;
        final int NUM_PRODUCTORES     = 2;
        final int NUM_CONSUMIDORES    = 2;

        System.out.println("=== Problema Productor-Consumidor con Semáforos ===");
        System.out.printf("Buffer capacidad: %d | Productores: %d | Consumidores: %d%n%n",
                CAPACIDAD, NUM_PRODUCTORES, NUM_CONSUMIDORES);

        // Crear hilos productores
        Thread[] productores = new Thread[NUM_PRODUCTORES];
        for (int i = 1; i <= NUM_PRODUCTORES; i++) {
            productores[i - 1] = new Productor(i, ITEMS_POR_PRODUCTOR);
        }

        // Crear hilos consumidores (consumen el total de items producidos)
        int itemsTotales = NUM_PRODUCTORES * ITEMS_POR_PRODUCTOR;
        Thread[] consumidores = new Thread[NUM_CONSUMIDORES];
        for (int i = 1; i <= NUM_CONSUMIDORES; i++) {
            consumidores[i - 1] = new Consumidor(i, itemsTotales / NUM_CONSUMIDORES);
        }

        // Lanzar todos los hilos
        for (Thread c : consumidores) c.start();
        for (Thread p : productores)  p.start();

        // Esperar a que todos terminen
        for (Thread p : productores)  p.join();
        for (Thread c : consumidores) c.join();

        System.out.println("\n=== Todos los hilos finalizaron correctamente ===");
        System.out.println("Buffer final: " + buffer);
    }
}