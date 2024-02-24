'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "a78b90f4306f53c45f6f31024ab6190a",
"assets/AssetManifest.bin.json": "622b9544c3c0cc321fc04948faf1ddc4",
"assets/AssetManifest.json": "8c4fc1b665d46a8c393e637cc3cc93c7",
"assets/assets/1.jpg": "6acb2e9cdc06d6f3f31e6c1be94bb96a",
"assets/assets/1m.jpg": "02c844fdbd751f8efb86d5906993040d",
"assets/assets/1w.jpg": "f72f751733d965ca9fed0a144831a36d",
"assets/assets/2.jpg": "e22bfdec0b05ad0943c68d3b4710462d",
"assets/assets/2m.jpg": "9fb64bdc636a4390ba0a016054b4b225",
"assets/assets/2w.jpg": "351b7b32e4820ad11153a9c109844394",
"assets/assets/3.jpg": "63d95e83398432a3879c5d39614b8cf8",
"assets/assets/3m.jpg": "c48cef9a82904dd36c8470c0289e3da4",
"assets/assets/3w.jpg": "28ec7deb6b7540a19460fd3756a7a6cf",
"assets/assets/4m.jpg": "5044292982d49d8a0dde51dce5dbb038",
"assets/assets/4w.jpg": "4d48cf4c6ee2cfc1ec9c98a651b651ae",
"assets/assets/5w.jpg": "3f63e59a37e8009633ba38f83caec073",
"assets/assets/add-image.png": "775da22a627e006945a00ae06df04820",
"assets/assets/auction.png": "965bbdb8f684f06e293c00d73deb5943",
"assets/assets/charity.png": "65b8186086d6891a5911ce115beba837",
"assets/assets/coin.json": "d0daeba9ccf6c48e2ce4efcb99484ff7",
"assets/assets/cslogo.png": "afccf5a7221ff7dda87fa8b5e6cba51f",
"assets/assets/edit.png": "ea274324f3f257f6441c8b959a4aad62",
"assets/assets/iconic.ttf": "b270706e08132325903d7b66d7fe4349",
"assets/assets/insta_logo.png": "b6202fffe96c1a2d24d50ffb5f0c99b5",
"assets/assets/invisible.png": "702f70b54258600c6bf3512c385343d4",
"assets/assets/OSA.png": "75796d271baf13cb3da93510842c0b26",
"assets/assets/RADIO.png": "4cebca0e3018b1cb55f07df4d9c8507f",
"assets/assets/resell.png": "7bfa93a2d76e1cf3fbd01ad8adea44b6",
"assets/assets/sale.png": "f74318c760e8f77ad60a69ab21bca775",
"assets/assets/sold.png": "c05535c198d0e66a9e74125d15404ddd",
"assets/assets/upload-images.png": "034f90f9cc09fdfcae65900525f8332d",
"assets/assets/visible.png": "c4b21fed8ea94e0e0b9a9aec6390e958",
"assets/assets/wave.json": "c58c23b7906e0330c24b80f2b7dbc1aa",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "cbe8d361ab596efef5a09f7d97d436a9",
"assets/NOTICES": "4e082a255e3ac753f3ad1f38aea5ed4d",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "89ed8f4e49bcdfc0b5bfc9b24591e347",
"assets/shaders/ink_sparkle.frag": "4096b5150bac93c41cbc9b45276bd90f",
"canvaskit/canvaskit.js": "eb8797020acdbdf96a12fb0405582c1b",
"canvaskit/canvaskit.wasm": "64edb91684bdb3b879812ba2e48dd487",
"canvaskit/chromium/canvaskit.js": "0ae8bbcc58155679458a0f7a00f66873",
"canvaskit/chromium/canvaskit.wasm": "f87e541501c96012c252942b6b75d1ea",
"canvaskit/skwasm.js": "87063acf45c5e1ab9565dcf06b0c18b8",
"canvaskit/skwasm.wasm": "4124c42a73efa7eb886d3400a1ed7a06",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "59a12ab9d00ae8f8096fffc417b6e84f",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "ce2beac435d56391e5f72e03e0d9f471",
"/": "ce2beac435d56391e5f72e03e0d9f471",
"main.dart.js": "fc5da70b48f40ab68ca3eeecf96d61e7",
"manifest.json": "c357da6a432fefa09f6303d8eac78734",
"version.json": "71df525bf8fa24d21a25cffa761c51d1"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
