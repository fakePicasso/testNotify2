//
//  Cookie.swift
//  testNotify2
//
//  Created by Kyle Louderback on 6/22/21.
//

import Foundation
import UIKit
import WebKit
//import XCPlayground

func testWebCookie() {
    let webView = WKWebView()

    // Expiry in 30 days
    let days: TimeInterval = 30 * 24 * 60 * 60

    guard let cookie = HTTPCookie(properties: [
        .domain: "https://schoolnotifier.bubbleapps.io/version-test/test2",
        .path: "/",
        .name: "ath_access_token",
        .value: "accessToken",
        .secure: "true",
        .expires: NSDate(timeIntervalSinceNow: days)
    ]) else { return }

    // WKWebsiteDataStore
    let websiteDataStore = WKWebsiteDataStore.nonPersistent()

    // WKWebViewConfiguration
    let configuration = WKWebViewConfiguration()
    configuration.websiteDataStore = websiteDataStore

    // WKWebView with non persistent data store
    //let webView = WKWebView(frame: CGRect.zero, configuration: configuration)
    

    webView.configuration.websiteDataStore.httpCookieStore.setCookie(cookie) {
        webView.configuration.websiteDataStore.httpCookieStore.getAllCookies { cookies in
            print("cookis: \(cookies)")

            /**
             cookis: [<NSHTTPCookie
                version:1
                name:ath_access_token
                value:accessToken
                expiresDate:'2020-08-26 09:57:09 +0000'
                created:'2020-07-27 09:57:09 +0000'
                sessionOnly:FALSE
                domain:domain
                partition:none
                sameSite:none
                path:/
                isSecure:TRUE
             path:"/" isSecure:TRUE>]
             */
        }
    }



    HTTPCookieStorage.shared.setCookie(cookie)

    //XCPlaygroundPage.currentPage.liveView = webView

}

//testWebCookie()
