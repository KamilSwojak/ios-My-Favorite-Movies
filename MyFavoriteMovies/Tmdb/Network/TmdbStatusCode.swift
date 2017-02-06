//
//  TmdbStatusCode.swift
//  My Favorite Movies
//
//  Created by Kamil Swojak on 17/12/2016.
//  Copyright © 2016 Kamil Swojak. All rights reserved.
//

import Foundation

enum TmdbStatusCode: Int{
    
    case Success = 1
    
    case InvalidService = 2
    
    case NoPermission = 3
    
    case InvalidFormat = 4
    
    case InvalidParameters = 5
    
    case InvalidId = 6
    
    case InvalidApiKey = 7
    
    case DuplicateEntry = 8
    
    case ServiceOffline = 9
    
    case SuspendedApiKey = 10
    
    case InternalError = 11
    
    case UpdatedSuccesfully = 12
    
    case DeletedSuccesfully = 13
    
    case AuthenticationFailed = 14
    
    case Failed = 15
    
    case DeviceDenied = 16
    
    case SessionDenied = 17
    
    case ValidationFailed = 18
    
    case InvalidAcceptHeader = 19
    
    case InvalidDateRange = 20
    
    case EntryNotFound = 21
    
    case InvalidPage = 22
    
    case InvalidDate = 23
    
    case RequestTimedOut = 24
    
    case RequestLimitExceeded = 25
    
    case MustAuthenticate = 26
    
    case TooManyAppendToResponseObjects = 27
    
    case InvalidTimezone = 28
    
    case MustConfirmAction = 29
    
    case InvalidLogin = 30
    
    case AccountDisabled = 31
    
    case EmailNotVerified = 32
    
    case InvalidRequestToken = 33
    
    case ResourceNotFound = 34
    
    var message: String{
        switch self {
        case .Success:
            return "Success."
            
        case .InvalidService:
            return "Invalid service: this service does not exist."
            
        case .NoPermission:
            return "Authentication failed: You do not have permissions to access the service."
            
        case .InvalidFormat:
            return "Invalid format: This service doesn't exist in that format."
            
        case .InvalidParameters:
            return "Invalid parameters: Your request parameters are incorrect."
            
        case .InvalidId:
            return "Invalid id: The pre-requisite id is invalid or not found."
            
        case .InvalidApiKey:
            return "Invalid API key: You must be granted a valid key."
            
        case .DuplicateEntry:
            return "Duplicate entry: The data you tried to submit already exists."
            
        case .ServiceOffline:
            return "Service offline: This service is temporarily offline, try again later."
            
            
        case .SuspendedApiKey:
            return "Suspended API key: Access to your account has been suspended, contact TMDb."
            
        case .InternalError:
            return "Internal error: Something went wrong, contact TMDb."
            
        case .UpdatedSuccesfully:
            return "The item/record was updated successfully."
            
        case .DeletedSuccesfully:
            return "The item/record was deleted successfully."
            
        case .AuthenticationFailed:
            return "Authentication failed."
            
        case .Failed:
            return "Failed."
            
        case .DeviceDenied:
            return "Device denied."
            
        case .SessionDenied:
            return "Session denied."
            
        case .ValidationFailed:
            return "Validation failed."
            
        case .InvalidAcceptHeader:
            return "Invalid accept header"
            
        case .InvalidDateRange:
            return "Invalid date range: Should be a range no longer than 14 days."
            
        case .EntryNotFound:
            return "Entry not found: The item you are trying to edit cannot be found."
            
        case .InvalidPage:
            return "Invalid page: Pages start at 1 and max at 1000. They are expected to be an integer."
            
        case .InvalidDate:
            return "Invalid date: Format needs to be YYYY-MM-DD."
            
        case .RequestTimedOut:
            return "Your request to the backend server timed out. Try again."
            
        case .RequestLimitExceeded:
            return "Your request count (#) is over the allowed limit of (40)."
            
        case .MustAuthenticate:
            return "You must provide a username and password."
            
        case .TooManyAppendToResponseObjects:
            return "Too many append to response objects: The maximum number of remote calls is 20."
            
        case .InvalidTimezone:
            return "Invalid timezone: Please consult the documentation for a valid timezone."
            
        case .MustConfirmAction:
            return "You must confirm this action: Please provide a confirm=true parameter."
            
        case .InvalidLogin:
            return "Invalid username and/or password: You did not provide a valid login."
            
        case .AccountDisabled:
            return "Account disabled: Your account is no longer active. Contact TMDb if this is an error."
            
        case .EmailNotVerified:
            return "Email not verified: Your email address has not been verified."
            
        case .InvalidRequestToken:
            return "Invalid request token: The request token is either expired or invalid."
            
        case .ResourceNotFound:
            return "The resource you requested could not be found."
        }
    }
    
    var code: Int{
        return self.rawValue
    }
}
