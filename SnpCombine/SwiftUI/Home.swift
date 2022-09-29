//
//  Home.swift
//  SnpCombine
//
//  Created by Kevin Harijanto on 21/09/22.
//

import SwiftUI
import SceneKit

struct Home: View {
    @State var scene: SCNScene? = SCNScene(named: "shoe.scn")
    @GestureState var offset: CGFloat = 0
    @State var isVerticalLook: Bool = false
    
    var body: some View {
        VStack {
            HeaderView()
            // 3d preview
            CustomSceneView(scene: $scene)
                .frame(height: 350)
                .padding(.top, -50)
                .padding(.bottom, -15)
                .zIndex(-10)
            
            CustomSeeker()
        }
    }
    
    @ViewBuilder
    func HeaderView() -> some View {
        HStack {
            Button {
                
            } label: {
                 Image(systemName: "arrow.left")
                    .font(.system(size: 16, weight: .heavy))
                    .foregroundColor(.white)
                    .frame(width: 42, height: 42)
                    .background {
                        RoundedRectangle(cornerRadius: 15,style: .continuous)
                            .fill(.white.opacity(0.2))
                    }
            }
            
            Spacer()
            
            Button {
                withAnimation(.easeInOut) {isVerticalLook.toggle()}
            } label: {
                 Image(systemName: "arrow.left.and.right.righttriangle.left.righttriangle.right.fill")
                    .font(.system(size: 16, weight: .heavy))
                    .foregroundColor(.white)
                    .rotationEffect(.init(degrees: isVerticalLook ? 0 : -90))
                    .frame(width: 42, height: 42)
                    .background {
                        RoundedRectangle(cornerRadius: 15,style: .continuous)
                            .fill(.white.opacity(0.2))
                    }
            }
        }
    }
    
    @ViewBuilder
    func CustomSeeker() -> some View {
        GeometryReader{ _ in
            Rectangle()
                .trim(from: 0, to: 0.474)
                .stroke(.linearGradient(colors: [
                    .clear,
                    .clear,
                    .white.opacity(0.2),
                    .white.opacity(0.6),
                    .white,
                    .white.opacity(0.6),
                    .white.opacity(0.2),
                    .clear,
                    .clear
                ], startPoint: .leading, endPoint: .trailing), style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round,miterLimit: 1, dash: [3], dashPhase: 1))
                .offset(x: offset)
                .overlay {
                    HStack(spacing: 3) {
                        Image(systemName: "arrowtriangle.left.fill")
                            .font(.caption)
                        Image(systemName: "arrowtriangle.right.fill")
                            .font(.caption)
                    }
                    .foregroundColor(.black)
                    .padding(.horizontal, 7)
                    .padding(.vertical, 10)
                    .background {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(.white)
                    }
                    .offset(y: -12)
                    .offset(x: offset)
                    .gesture(
                        DragGesture()
                            .updating($offset, body: { value, out, _ in
                                out = value.location.x - 20
                            })
                        )
                    }
                }
            .frame(height: 20)
            .animation(.easeInOut(duration: 0.4), value: offset == .zero)
            .onChange(of: offset, perform: { newValue in
                rotateObject(animate: offset == .zero)
            })
        }
    
    func rotateObject(animate: Bool = false) {
        if animate {
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 0.4
        }
        let newAngle = Float((offset * .pi) / 100)
        
        if isVerticalLook {
            scene?.rootNode.eulerAngles.y = newAngle
        } else {
            scene?.rootNode.eulerAngles.x = newAngle
        }
        
        if animate {
            SCNTransaction.commit()
        }
    }
    
    
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
