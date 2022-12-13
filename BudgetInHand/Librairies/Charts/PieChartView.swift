//
//  PieChartView.swift
//
//
//  Created by Nazar Ilamanov on 4/23/21.
//

import SwiftUI

@available(OSX 10.15, *)
public struct PieChartView: View {
   
    public let isClickable: Bool
    public let values: [Double]
    public let names: [String]
    public let formatter: (Double) -> String
    public let angleSpace: Angle
    public var colors: [Color]
    public var iconNames: [String]
    public var backgroundColor: Color
    
    var blueColor : Color = Color.fromInts(r: 41, g: 55, b: 131)
    
    public var widthFraction: CGFloat
    public var innerRadiusFraction: CGFloat
    
    @State private var activeIndex: Int = -1
    
    var slices: [PieSliceData] {
        let sum = values.reduce(0, +)
        var endDeg: Double = 0
        var tempSlices: [PieSliceData] = []
        
        for (i, value) in values.enumerated() {
            let degrees: Double = value * 360 / sum
            tempSlices.append(PieSliceData(startAngle: Angle(degrees: endDeg), endAngle: Angle(degrees: endDeg + degrees), text: String(format: "%.0f%%", value * 100 / sum), color: self.colors[i], iconName: self.iconNames[i]))
            endDeg += degrees
        }
        return tempSlices
    }
    
    public init(isClickable: Bool,values:[Double], names: [String], formatter: @escaping (Double) -> String, colors: [Color] = [Color.blue, Color.green, Color.orange], iconNames: [String], backgroundColor: Color, widthFraction: CGFloat = 0.75, innerRadiusFraction: CGFloat = 0.60, angleSpace: Angle){
        self.values = values
        self.names = names
        self.formatter = formatter
        self.colors = colors
        self.iconNames = iconNames
        self.backgroundColor = backgroundColor
        self.widthFraction = widthFraction
        self.innerRadiusFraction = innerRadiusFraction
        self.angleSpace = angleSpace
        self.isClickable = isClickable
    }
    
    public var body: some View {
        GeometryReader { geometry in
            VStack{
                ZStack{
                    ForEach(0..<self.values.count, id: \.self){ i in
                        PieSlice(pieSliceData: self.slices[i], angleSpace: angleSpace)
                            .scaleEffect(self.activeIndex == i ? 1.03 : 1)
                            .animation(Animation.spring())
                    }
                    .frame(width: widthFraction * geometry.size.width, height: widthFraction * geometry.size.width)
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { value in
                                let radius = 0.5 * widthFraction * geometry.size.width
                                let diff = CGPoint(x: value.location.x - radius, y: radius - value.location.y)
                                let dist = pow(pow(diff.x, 2.0) + pow(diff.y, 2.0), 0.5)
                                if (dist > radius || dist < radius * innerRadiusFraction) {
                                    self.activeIndex = -1
                                    return
                                }
                                var radians = Double(atan2(diff.x, diff.y))
                                if (radians < 0) {
                                    radians = 2 * Double.pi + radians
                                }
                                for (i, slice) in slices.enumerated() {
                                    if (radians < slice.endAngle.radians) {
                                        self.activeIndex = i
                                        break
                                    }
                                }
                            }
                            .onEnded { value in
                                self.activeIndex = -1
                            }
                    )
                    Circle()
                        .fill(self.backgroundColor)
                        .frame(width: widthFraction * geometry.size.width * innerRadiusFraction, height: widthFraction * geometry.size.width * innerRadiusFraction)
                    VStack {
                        Text(self.activeIndex == -1 ? "Total" : names[self.activeIndex])
                            .font(.title)
                            .foregroundColor(Color.gray)
                        Text(self.formatter(self.activeIndex == -1 ? values.reduce(0, +) : values[self.activeIndex]))
                            .font(.title)
                            .foregroundColor(blueColor)
                    }
                }
                PieChartRows(
                    isClickable: self.isClickable,
                    angleSpace: self.angleSpace,
                    colors: self.colors,
                    names: self.names,
                    values: self.values.map { self.formatter($0) },
                    percents: self.values.map {
                        String(format: "%.0f%%", $0 * 100 / self.values.reduce(0, +))
                    },
                    iconNames: iconNames
                )
            }
            .background(self.backgroundColor)
            .foregroundColor(Color.white)
        }
    }
}
@available(OSX 10.15, *)
struct PieChartRows: View {
    var isClickable: Bool
    var angleSpace: Angle
    var colors: [Color]
    var names: [String]
    var values: [String]
    var percents: [String]
    var iconNames: [String]
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    @StateObject private var showDetail = BudgetInHandModel()
    
    var body: some View {
        NavigationStack{
            LazyVGrid(columns: columns){
                ForEach(0..<self.values.count, id: \.self){ i in
                    HStack {
                        if (isClickable == true)   {
                            NavigationLink(
                                destination : DetailExpenses(value: Double(self.values[i]) ?? 0, name: self.names[i], image: self.iconNames[i], colors: self.colors[i]))
                            {
                                detailExpense(index: i)
                            }
                        } else {
                            detailExpense(index: i)
                        }
                    }
                    .environmentObject(showDetail)
                    .padding(10)
                    .background(Color.white)
                    .cornerRadius(10)
                    
                }
            }
        }
        .padding(20)
    }
    func detailExpense(index: Int) -> some View{
        HStack{
            VStack(alignment: .leading){
                ZStack{
                    RoundedRectangle(cornerRadius: 5.0)
                        .fill(self.colors[index])
                        .frame(width: 20, height: 20)
                    Image(systemName:  self.iconNames[index])
                        .aspectRatio(contentMode: .fit)
                }
                Text(self.names[index])
                    .foregroundColor(Color("Blue800"))
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text(self.values[index])
                    .foregroundColor(Color("Blue800"))
                Text(self.percents[index])
                    .foregroundColor(Color.gray)
            }
        }
    }
}
@available(OSX 10.15.0, *)
struct PieChartView_Previews: PreviewProvider {
    static var previews: some View {
        PieChartView(isClickable : true ,values: [1300, 500, 300], names: ["Carburant", "Energie", "Frais domestique","Comissions"], formatter: {value in String(format: "$%.2f", value)}, iconNames: ["car", "trash", "home"], backgroundColor: Color.fromInts(r: 250, g: 250, b: 250), angleSpace: Angle(degrees: 3))
    }
}

