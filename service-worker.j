const cacheName = "connectme-cache-v1";
const cacheAssets = [
  "/",
  "/index.html",
  "/login.html",
  "/register.html",
  "/profile.html",
  "/home.html",
  "/settings.html",
  "/style.css",
  "/app.js",
  // Add all the files used in your app here
];

// Install
self.addEventListener("install", (e) => {
  e.waitUntil(
    caches.open(cacheName).then((cache) => {
      console.log("Caching files");
      return cache.addAll(cacheAssets);
    })
  );
});

// Activate
self.addEventListener("activate", (e) => {
  e.waitUntil(
    caches.keys().then((keyList) =>
      Promise.all(
        keyList.map((key) => {
          if (key !== cacheName) {
            return caches.delete(key);
          }
        })
      )
    )
  );
});

// Fetch
self.addEventListener("fetch", (e) => {
  e.respondWith(
    caches.match(e.request).then((response) => {
      return response || fetch(e.request);
    })
  );
});
