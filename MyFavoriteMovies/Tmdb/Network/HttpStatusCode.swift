//
//  HttpStatusCode.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 06/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import Foundation

//http://www.restapitutorial.com/httpstatuscodes.html#
//https://en.wikipedia.org/wiki/List_of_HTTP_status_codes

enum HttpStatusCode: Int{
    
    //MARK: Ranges
    
    
    /// This class of status code indicates a provisional response, consisting only of the Status-Line and optional headers, and is terminated by an empty line. There are no required headers for this class of status code. Since HTTP/1.0 did not define any 1xx status codes, servers MUST NOT send a 1xx response to an HTTP/1.0 client except under experimental conditions.
    enum Informational{
        var range: ClosedRange<Int>{
            return 100...199
        }
    }
    
    /// This class of status codes indicates the action requested by the client was received, understood, accepted and processed successfully.
    struct Success{
        var range: ClosedRange<Int>{
            return 200...299
        }
    }
    
    /// The client must take additional action to complete the request. This class of status code indicates that further action needs to be taken by the user agent in order to fulfil the request. The action required may be carried out by the user agent without interaction with the user if and only if the method used in the second request is GET or HEAD. A user agent should not automatically redirect a request more than five times, since such redirections usually indicate an infinite loop.
    enum Redirection{
        var range: ClosedRange<Int>{
            return 300...399
        }
    }
    
    /// The 4xx class of status code is intended for cases in which the client seems to have erred. Except when responding to a HEAD request, the server should include an entity containing an explanation of the error situation, and whether it is a temporary or permanent condition. These status codes are applicable to any request method. User agents should display any included entity to the user.
    enum ClientError{
        var range: ClosedRange<Int>{
            return 400...499
        }
    }
    
    /// The server failed to fulfill an apparently valid request. Response status codes beginning with the digit "5" indicate cases in which the server is aware that it has encountered an error or is otherwise incapable of performing the request. Except when responding to a HEAD request, the server should include an entity containing an explanation of the error situation, and indicate whether it is a temporary or permanent condition. Likewise, user agents should display any included entity to the user. These response codes are applicable to any request method.
    enum ServerError{
        var range: ClosedRange<Int>{
            return 500...599
        }
    }
    
    
    //MARK: Informational
    
    /// This means that the server has received the request headers, and that the client should proceed to send the request body (in the case of a request for which a body needs to be sent; for example, a POST request). If the request body is large, sending it to a server when a request has already been rejected based upon inappropriate headers is inefficient. To have a server check if the request could be accepted based on the request's headers alone, a client must send Expect: 100-continue as a header in its initial request and check if a 100 Continue status code is received in response before continuing (or receive 417 Expectation Failed and not continue).
    case Continue = 100
    
    /// This means the requester has asked the server to switch protocols and the server is acknowledging that it will do so.
    case SwitchingProtocols = 101
    
    /// As a WebDAV request may contain many sub-requests involving file operations, it may take a long time to complete the request. This code indicates that the server has received and is processing the request, but no response is available yet. This prevents the client from timing out and assuming the request was lost.
    case Processing = 102
    
    
    // MARK: Success
    
    ///Standard response for successful HTTP requests. The actual response will depend on the request method used. In a GET request, the response will contain an entity corresponding to the requested resource. In a POST request the response will contain an entity describing or containing the result of the action.
    case OK = 200
    
    ///The request has been fulfilled and resulted in a new resource being created.
    case Created = 201
    
    ///The request has been accepted for processing, but the processing has not been completed. The request might or might not eventually be acted upon, as it might be disallowed when processing actually takes place.
    case Accepted = 202
    
    ///The server successfully processed the request, but is returning information that may be from another source.
    case NonAuthoritativeInformation = 203
    
    ///The server successfully processed the request, but is not returning any content.
    case NoContent = 204
    
    ///The server successfully processed the request, but is not returning any content. Unlike a 204 response, this response requires that the requester reset the document view.
    case ResetContent = 205
    
    ///The server is delivering only part of the resource due to a range header sent by the client. The range header is used by tools like wget to enable resuming of interrupted downloads, or split a download into multiple simultaneous streams.
    case PartialContent = 206
    
    ///The message body that follows is an XML message and can contain a number of separate response codes, depending on how many sub-requests were made.
    case MultiStatus = 207
    
    ///The members of a DAV binding have already been enumerated in a previous reply to this request, and are not being included again.
    case AlreadyReported = 208
    
    ///The server has fulfilled a GET request for the resource, and the response is a representation of the result of one or more instance-manipulations applied to the current instance.
    case IMUsed = 226

    
    //MARK: Redirection
    
    /// Indicates multiple options for the resource that the client may follow. It, for instance, could be used to present different format options for video, list files with different extensions, or word sense disambiguation.
    case MultipleChoices = 300
    
    /// This and all future requests should be directed to the given URI.
    case MovedPermanently = 301
    
    /// This is an example of industry practice contradicting the standard.[2] The HTTP/1.0 specification (RFC 1945) required the client to perform a temporary redirect (the original describing phrase was "Moved Temporarily"), but popular browsers implemented 302 with the functionality of a 303 See Other. Therefore, HTTP/1.1 added status codes 303 and 307 to distinguish between the two behaviours. However, some Web applications and frameworks use the 302 status code as if it were the 303.
    case Found = 302
    
    /// The response to the request can be found under another URI using a GET method. When received in response to a POST (or PUT/DELETE), it should be assumed that the server has received the data and the redirect should be issued with a separate GET message.
    case SeeOther = 303
    
    /// Indicates the resource has not been modified since last requested. Typically, the HTTP client provides a header like the If-Modified-Since header to provide a time against which to compare. Using this saves bandwidth and reprocessing on both the server and client, as only the header data must be sent and received in comparison to the entirety of the page being re-processed by the server, then sent again using more bandwidth of the server and client.
    case NotModified = 304
    
    /// Many HTTP clients (such as Mozilla and Internet Explorer) do not correctly handle responses with this status code, primarily for security reasons.
    case UseProxy = 305
    
    /// In this case, the request should be repeated with another URI; however, future requests can still use the original URI. In contrast to 302, the request method should not be changed when reissuing the original request. For instance, a POST request must be repeated using another POST request.
    case TemporarilyRedirect = 307
    
    /// The request, and all future requests should be repeated using another URI. 307 and 308 (as proposed) parallel the behaviours of 302 and 301, but do not require the HTTP method to change. So, for example, submitting a form to a permanently redirected resource may continue smoothly.
    case PermanentRedirect = 308
    
    
    //MARK: Client Error
    
    /// The request cannot be fulfilled due to bad syntax.
    case BadRequest = 400
    
    /// Similar to 403 Forbidden, but specifically for use when authentication is possible but has failed or not yet been provided. The response must include a WWW-Authenticate header field containing a challenge applicable to the requested resource. See Basic access authentication and Digest access authentication.
    case Unauthorized = 401
    
    /// Reserved for future use. The original intention was that this code might be used as part of some form of digital cash or micropayment scheme, but that has not happened, and this code is not usually used. As an example of its use, however, Apple's MobileMe service generates a 402 error ("httpStatusCode:402" in the Mac OS X Console log) if the MobileMe account is delinquent.
    case PaymentRequired = 402
    
    /// The request was a legal request, but the server is refusing to respond to it. Unlike a 401 Unauthorized response, authenticating will make no difference.
    case Forbidden = 403
    
    /// The requested resource could not be found but may be available again in the future. Subsequent requests by the client are permissible.
    case NotFound = 404
    
    /// A request was made of a resource using a request method not supported by that resource; for example, using GET on a form which requires data to be presented via POST, or using PUT on a read-only resource.
    case MethodNotAllowed = 405
    
    /// The requested resource is only capable of generating content not acceptable according to the Accept headers sent in the request.
    case NotAcceptable = 406
    
    /// The client must first authenticate itself with the proxy.
    case ProxyAuthenticationRequired = 407
    
    /// he server timed out waiting for the request. According to W3 HTTP specifications: "The client did not produce a request within the time that the server was prepared to wait. The client MAY repeat the request without modifications at any later time."
    case RequestTimeout = 408
    
    /// Indicates that the request could not be processed because of conflict in the request, such as an edit conflict.
    case Conflict = 409
    
    /// Indicates that the resource requested is no longer available and will not be available again. This should be used when a resource has been intentionally removed and the resource should be purged. Upon receiving a 410 status code, the client should not request the resource again in the future. Clients such as search engines should remove the resource from their indices. Most use cases do not require clients and search engines to purge the resource, and a "404 Not Found" may be used instead.
    case Gone = 410
    
    /// The request did not specify the length of its content, which is required by the requested resource.
    case LengthRequired = 411
    
    /// The server does not meet one of the preconditions that the requester put on the request.
    case PreconditionFailed = 412
    
    /// The request is larger than the server is willing or able to process.
    case RequestEntityTooLarge = 413
    
    /// The URI provided was too long for the server to process.
    case RequestURITooLong = 414
    
    /// The request entity has a media type which the server or resource does not support. For example, the client uploads an image as image/svg+xml, but the server requires that images use a different format.
    case UnsupportedMediaType = 415
    
    /// The client has asked for a portion of the file, but the server cannot supply that portion. For example, if the client asked for a part of the file that lies beyond the end of the file.
    case RequestedRangeNotSatisfiable = 416
    
    /// The server cannot meet the requirements of the Expect request-header field.
    case ExpectationFailed = 417
    
    /// This code was defined in 1998 as one of the traditional IETF April Fools' jokes, in RFC 2324, Hyper Text Coffee Pot Control Protocol, and is not expected to be implemented by actual HTTP servers. However, known implementations do exist. An Nginx HTTP server uses this code to simulate goto-like behaviour in its configuration.
    case ImATeaPot = 418
    
    /// Returned by the Twitter Search and Trends API when the client is being rate limited. Likely a reference to this number's association with marijuana. Other services may wish to implement the 429 Too Many Requests response code instead.
    case EnahnceYourCalm = 420
    
    /// The request was well-formed but was unable to be followed due to semantic errors.
    case UnprocessableEntity = 422
    
    /// The resource that is being accessed is locked.
    case Locked = 423
    
    /// The request failed due to failure of a previous request (e.g. a PROPPATCH).
    case FailedDependency = 424
    
    /// Defined in drafts of "WebDAV Advanced Collections Protocol", but not present in "Web Distributed Authoring and Versioning (WebDAV) Ordered Collections Protocol".
    case ReservedForWebDAV = 425
    
    ///The client should switch to a different protocol such as TLS/1.0.
    case UpgradeRequired = 426
    
    /// The origin server requires the request to be conditional. Intended to prevent "the "lost update" problem, where a client GETs a resource's state, modifies it, and PUTs it back to the server, when meanwhile a third party has modified the state on the server, leading to a conflict.
    case PreconditionRequired = 428
    
    /// The user has sent too many requests in a given amount of time. Intended for use with rate limiting schemes.
    case TooManyRequests = 429
    
    /// The server is unwilling to process the request because either an individual header field, or all the header fields collectively, are too large.
    case RequestHeaderFieldsTooLarge = 431
    
    /// An Nginx HTTP server extension. The server returns no information to the client and closes the connection (useful as a deterrent for malware).
    case NoResponse = 444
    
    /// Intended to be used when resource access is denied for legal reasons, e.g. censorship or government-mandated blocked access. A reference to the 1953 dystopian novel Fahrenheit 451, where books are outlawed, and the autoignition temperature of paper, 451°F.
    case UnavailableForLegalReasons = 451
    
    /// An Nginx HTTP server extension. This code is introduced to log the case when the connection is closed by client while HTTP server is processing its request, making server unable to send the HTTP header back.
    case ClientClosedRequest = 499
    

    //MARK: Server Error
    
    /// A generic error message, given when no more specific message is suitable.
    case InternalServerError = 500
    
    /// The server either does not recognise the request method, or it lacks the ability to fulfill the request.
    case NotImplemented = 501
    
    /// The server was acting as a gateway or proxy and received an invalid response from the upstream server.
    case BadGateway = 502
    
    /// The server is currently unavailable (because it is overloaded or down for maintenance). Generally, this is a temporary state.
    case ServiceUnavailable = 503
    
    /// The server was acting as a gateway or proxy and did not receive a timely response from the upstream server.
    case GatewayTimeout = 504
    
    /// The server does not support the HTTP protocol version used in the request.
    case HTTPVersionNotSupported = 505
    
    /// Transparent content negotiation for the request results in a circular reference.
    case VariantAlsoNegotiates = 506
    
    /// The server is unable to store the representation needed to complete the request.
    case InsufficientStorage = 507
    
    /// The server detected an infinite loop while processing the request (sent in lieu of 208).
    case LoopDetected = 508
    
    /// This status code, while used by many servers, is not specified in any RFCs.
    case BandwithLimitExceeded = 509
    
    /// Further extensions to the request are required for the server to fulfill it.
    case NotExtended = 510
    
    /// The client needs to authenticate to gain network access. Intended for use by intercepting proxies used to control access to the network (e.g., "captive portals" used to require agreement to Terms of Service before granting full Internet access via a Wi-Fi hotspot).
    case NetworkAuthenticationRequired = 511
    
    /// This status code is not specified in any RFCs, but is used by some HTTP proxies to signal a network read timeout behind the proxy to a client in front of the proxy.
    case NetworkReadTimeoutError = 598
    
    /// This status code is not specified in any RFCs, but is used by some HTTP proxies to signal a network connect timeout behind the proxy to a client in front of the proxy.
    case NetworkConnectTimoutError = 599
    
    
    //MARK: Invalid
    
    case InvalidHttpStatusCode = -1
    
    
    //MARK: Helpers
    
    var isInformational: Bool{
        return (100...199).contains(self.rawValue)
    }
    
    var isSuccess: Bool{
        return (200...299).contains(self.rawValue)
    }
    
    var isRedirection: Bool{
        return (300...399).contains(self.rawValue)
    }
    
    var isClientError: Bool{
        return (400...499).contains(self.rawValue)
    }
    
    var isServerError: Bool{
        return (500...599).contains(self.rawValue)
    }
    
    static func isValidHttpCode(code: Int) -> Bool{
        return HttpStatusCode(rawValue: code) != nil
    }
    
    static func from(code: Int) -> HttpStatusCode?{
        return HttpStatusCode(rawValue: code)
    }
}
