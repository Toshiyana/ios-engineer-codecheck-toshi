//
//  APIResponseStatusCodeHandler.swift
//  iOSEngineerCodeCheck
//
//  Created by Toshiyana on 2022/07/25.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Moya
import RxSwift

enum APIError: Error {
    case unexpectedServerError
    var errorTitle: String? {
        switch self {
        case .unexpectedServerError:
            return "予期せぬサーバーエラーが発生しました"
        }
    }
}

final class APIResponseStatusCodeHandler {
    // ステータスコードハンドリング共通メソッド
    static func handleStatusCode(_ response: PrimitiveSequence<SingleTrait, Response>.Element) throws {
        print("DEBUG: handleStatusCode:: \(response.statusCode)")
        switch response.statusCode {
        case 200...399:
            break
        default:
            throw APIError.unexpectedServerError
        }
    }
}
