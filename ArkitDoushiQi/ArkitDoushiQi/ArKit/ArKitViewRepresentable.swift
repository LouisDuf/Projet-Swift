//
//  ArKitViewRepresentable.swift
//  ArkitDoushiQi
//
//  Created by Enzo JOLYS on 12/06/2024.
//

import Foundation
import SwiftUI
import DouShouQiModel
import ARKit
import RealityKit
import UIKit

struct ArKitViewRepresentable : UIViewRepresentable {
    
    let vmArkit:VMArkit
    
    init(_ vmArkit:VMArkit){
        self.vmArkit = vmArkit
    }
    
    func makeUIView(context: Context) -> ArKitView {
        let arView = ArKitView(vmArkit)
        let anchor = arView.defineAnchors()
        vmArkit.setup(anchor)
        arView.addGesture(vmArkit.pieces)
        return arView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) { }
}
