let resolveUrl = (baseUrl, size) => baseUrl->String.replace("__SIZE__", size)

@val external encodeURIComponent: string => string = "encodeURIComponent"

let nextImageUrl = src =>
  `/_next/image?url=${encodeURIComponent(src)}&w=640&q=75`
