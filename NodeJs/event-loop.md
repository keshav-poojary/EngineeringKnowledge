# JavaScript Runtime Components and Event Loop Queues

## V8 Engine

- **Heap:** Memory storage area for variables and functions.
- **Call Stack:** Manages execution of functions. Functions are pushed to the stack when called and popped out after returning.

## libuv

- Handles asynchronous operations such as I/O.
- Ensures the main thread is **non-blocking** by delegating async tasks.

## Event Loop

- A design pattern that orchestrates the execution of synchronous and asynchronous code.
- Continuously checks different queues to process callbacks and tasks without blocking the main thread.

### Queues in the Event Loop

| Queue Name          | Description                                                               | Examples                                             |
| ------------------- | ------------------------------------------------------------------------- | ---------------------------------------------------- |
| **Timer Queue**     | Executes callbacks from `setTimeout`, `setInterval`                       | `setTimeout(fn, delay)`, `setInterval(fn, interval)` |
| **I/O Queue**       | Handles callbacks from asynchronous I/O operations (file system, network) | `fs.readFile()`, `http.get()`                        |
| **Check Queue**     | Executes callbacks from `setImmediate()`                                  | `setImmediate(fn)`                                   |
| **Close Queue**     | Handles `close` events of async tasks                                     | Socket or handle close events                        |
| **Microtask Queue** | Handles microtasks like promises and process.nextTick()                   | `Promise.then()`, `process.nextTick()`               |

- **Microtask queue** is **not part of libuv** but part of the V8 engine.
- Microtasks have **higher priority** and run **immediately after the currently executing script and before the next macrotask**.

---

## Summary Flow

1. Synchronous code runs first (call stack).
2. When async operations complete, their callbacks enter respective queues.
3. Event loop picks tasks from the macrotask queues (timer, I/O, check, close).
4. After each macrotask, the microtask queue is processed fully before moving on.

# JavaScript Event Loop Execution Order

1. **Execute all synchronous code** (call stack).

2. After the current script finishes:

   - **Process all tasks in the Microtask Queue** completely (e.g., `Promise.then()`, `process.nextTick()`).
   - Microtasks run **before** any macrotasks.

3. Then pick the next macrotask (one from the macrotask queues):

   - Timer Queue (`setTimeout`, `setInterval`) — if the timer delay has elapsed.
   - I/O Queue (file system, network callbacks).
   - Check Queue (`setImmediate`).
   - Close Queue (e.g., socket close events).

4. After running one macrotask, **process the Microtask Queue again** fully.

5. Repeat steps 3 and 4 continuously.

---

![Event Loop Diagram](https://media.licdn.com/dms/image/v2/D5612AQHXppQIej90rA/article-cover_image-shrink_720_1280/B56ZZZi0nvGUAQ-/0/1745259023668?e=2147483647&v=beta&t=Ik0NV91-OCZIMtfl8K565u1t7wVSnIINvQsiWsTP4Cc)

### Important Notes

- **Microtasks always run immediately after the current task, before moving to the next macrotask.**
- `process.nextTick()` (Node.js) callbacks run **before** Promise microtasks.
- `setImmediate()` callbacks (Check Queue) run after I/O callbacks and timers but before the next timer cycle.

---
