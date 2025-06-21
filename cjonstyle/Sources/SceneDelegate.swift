//
//  SceneDelegate.swift
//  cjonstyle
//
//  Created by 이덕화 on 2025/06/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = ListViewController.create(with: ListViewModel(with: ProductUseCase()))
        window?.makeKeyAndVisible()
    }
}
