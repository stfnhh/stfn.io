function handler(event) {
    var request = event.request;
    var host = request.headers.host.value;

    // Check if the host starts with "www."
    if (host.startsWith("www.")) {
        var domain = host.replace("www.", ""); // Remove "www." from the host
        return {
            statusCode: 301, // Permanent redirect
            statusDescription: "Moved Permanently",
            headers: {
                "location": { "value": `https://${domain}${request.uri}` }
            }
        };
    }

    // If no redirect is needed, proceed with the request
    return request;
}