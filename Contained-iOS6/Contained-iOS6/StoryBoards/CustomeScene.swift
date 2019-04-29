//
//  CustomeScene.swift
//  Contained-iOS6
//
//  Created by Hector Steven on 4/29/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit
import SpriteKit

class CustomeScene: SKScene , SettingsControllerProtocol{
	var settingsController: SettingsController?
	let crab = SKSpriteNode()
	
	// Add and center child, initializing animation sequence
	override func sceneDidLoad() {
		super.sceneDidLoad()
		addChild(crab)
		crab.loadTextures(named: "HappyCrab", forKey: SKSpriteNode.textureKey)
		crab.position = CGPoint(x: frame.midX, y: frame.midY)
	}
	
	// Move to touch
	public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		
		// Fetch a touch or leave
		guard !touches.isEmpty, let touch = touches.first else { return }
		
		// Retrieve position
		let position = touch.location(in: self)
		
		// Create move action
		let actionDuration = 1.0
		let moveAction = SKAction.move(to: position, duration: actionDuration)
		
		let rollAction = SKAction.rotate(byAngle: CGFloat.pi * 2, duration: actionDuration)
		let zoomAction = SKAction.scale(by: 1.3, duration: 0.3)
		let unzoomAction = SKAction.scale(to: 1.0, duration: 0.1)
		
		guard let seting = settingsController?.seting else { return }
		
		switch seting.shouldZoom {
		case false:
			crab.run(moveAction)
		case true:
			let sequenceAction = SKAction.sequence([zoomAction, moveAction, unzoomAction])
			crab.run(sequenceAction)
		}
		
		if seting.shouldRoll {
			crab.run(rollAction)
		}
	}
}