const os = require('os');
const path = require('path');
const crypto = require('crypto');

// OS Module examples
console.log('--- OS Module Info ---');

// Operating system platform
console.log('OS platform:', os.platform()); // e.g., 'linux', 'win32', 'darwin'

// OS release version
console.log('OS release:', os.release());

// Total system memory in bytes
console.log('Total memory:', os.totalmem(), 'bytes');

// Free system memory in bytes
console.log('Free memory:', os.freemem(), 'bytes');

// System uptime in seconds
console.log('System uptime:', os.uptime(), 'seconds');

// CPU architecture (e.g., x64, arm)
console.log('CPU arch:', os.arch());

// Info about each CPU core
console.log('CPUs:', os.cpus());

// Network interfaces info (IP addresses, MAC addresses)
console.log('Network Interfaces:', os.networkInterfaces());

// User info object
console.log('Current User Info:', os.userInfo());

// Temporary directory path
console.log('Temp directory:', os.tmpdir());

// Home directory path
console.log('Home directory:', os.homedir());

// Path module: resolve vs join vs basename
console.log('\n--- Path Module Info ---');
console.log('Path.resolve:', path.resolve('folder', 'file.txt'));
console.log('Path.join:', path.join('/foo', 'bar', 'baz/asdf', 'quux', '..'));
console.log('Path.basename:', path.basename('/foo/bar/baz/asdf/quux.html'));
console.log('Path.extname:', path.extname('index.html'));

// Crypto: Generate a random UUID 
console.log('\n--- Crypto Module ---');
const uuid = crypto.randomUUID();
console.log('Random UUID:', uuid);


// Timers module example: setTimeout, setInterval
console.log('\n--- Timers ---');
setTimeout(() => {
  console.log('This runs once after 1 second');
}, 1000);

let count = 0;
const intervalId = setInterval(() => {
  count++;
  console.log(`Interval running ${count} times`);
  if (count === 3) {
    clearInterval(intervalId);
    console.log('Interval cleared');
  }
}, 500);

// Buffer example: create buffer and convert to string
console.log('\n--- Buffer ---');
const buf = Buffer.from('Node.js buffer example');
console.log('Buffer content:', buf.toString());
console.log('Buffer length:', buf.length);


// EventEmitter example
const event = new EventEmitter();
event.on('order-pizza', (size, toppings) => {
  console.log('pizza order received!');
  if (size === 'large') {
    console.log('Serve Cold Drinks as well');
  }
});
event.emit('order-pizza', 'large', 'paneer');

// Write and read file synchronously
fs.writeFileSync('./greet.txt', 'hello keshav');
const dataSync = fs.readFileSync('./greet.txt', 'utf8');
console.log('Sync read:', dataSync);

// Read file asynchronously using promises
fsPromise.readFile('./greet.txt', 'utf8')
  .then(dataAsync => console.log('Async read:', dataAsync))
  .catch(err => console.error('Error reading file asynchronously:', err));

// Streams: copy file with progress logging
const readStream = fs.createReadStream('./greet.txt', 'utf8');
const writeStream = fs.createWriteStream('./greet-copy.txt', 'utf8');

readStream.on('data', chunk => console.log('Chunk:', chunk));
readStream.on('end', () => console.log('Finished reading greet.txt'));
writeStream.on('finish', () => console.log('File copied to greet-copy.txt'));
writeStream.on('error', err => console.error('Write error:', err));

readStream.pipe(writeStream);

// HTTP Server returning JSON with simple routing
const server = http.createServer((req, res) => {
  if (req.url === '/hello') {
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({ message: 'Hello, Keshav!' }));
  } else if (req.url === '/time') {
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({ time: new Date().toISOString() }));
  } else {
    res.writeHead(404, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({ error: 'Not Found' }));
  }
});

// Listen on port 3000
// server.listen(3000, () => {
//   console.log('Server running at http://localhost:3000/');
//   console.log('UV_THREADPOOL_SIZE:', process.env.UV_THREADPOOL_SIZE || 'default (4)');
// });
