//
//  parents_view.swift
//  schoolspace-beyram
//
//  Created by Mac Mini 7 on 30/4/2023.
//

import SwiftUI

@available(iOS 13.0, *)
public struct Teachers_view : View {
    
    // MARK: Internal State
    
    /// Internal state to keep track of the selection index
    @State private var selectionState: Int = 0 {
        didSet {
            selection = selectionState
        }
    }
    
    // MARK: Required Properties
    
    /// Binding the selection index which will  re-render the consuming view
    @Binding var selection: Int
    
    /// The title of the tabs
    let tabs: [String]
    
    // Mark: View Customization Properties
    
    /// The font of the tab title
    let font: Font
    
    /// The selection bar sliding animation type
    let animation: Animation
    
    /// The accent color when the tab is selected
    let activeAccentColor: Color
    
    /// The accent color when the tab is not selected
    let inactiveAccentColor: Color
    
    /// The color of the selection bar
    let selectionBarColor: Color
    
    /// The tab color when the tab is not selected
    let inactiveTabColor: Color
    
    /// The tab color when the tab is  selected
    let activeTabColor: Color
    
    /// The height of the selection bar
    let selectionBarHeight: CGFloat
    
    /// The selection bar background color
    let selectionBarBackgroundColor: Color
    
    /// The height of the selection bar background
    let selectionBarBackgroundHeight: CGFloat
    
    // MARK: init
    
    public init(selection: Binding<Int>,
                tabs: [String],
                font: Font = .body,
                animation: Animation = .spring(),
                activeAccentColor: Color = .blue,
                inactiveAccentColor: Color = Color.black.opacity(0.4),
                selectionBarColor: Color = .blue,
                inactiveTabColor: Color = .clear,
                activeTabColor: Color = .clear,
                selectionBarHeight: CGFloat = 2,
                selectionBarBackgroundColor: Color = Color.gray.opacity(0.2),
                selectionBarBackgroundHeight: CGFloat = 1) {
        self._selection = selection
        self.tabs = tabs
        self.font = font
        self.animation = animation
        self.activeAccentColor = activeAccentColor
        self.inactiveAccentColor = inactiveAccentColor
        self.selectionBarColor = selectionBarColor
        self.inactiveTabColor = inactiveTabColor
        self.activeTabColor = activeTabColor
        self.selectionBarHeight = selectionBarHeight
        self.selectionBarBackgroundColor = selectionBarBackgroundColor
        self.selectionBarBackgroundHeight = selectionBarBackgroundHeight
    }
    
    // MARK: View Construction
    
    public var body: some View {
        assert(tabs.count > 1, "Must have at least 2 tabs")
        
        return VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                ForEach(self.tabs, id:\.self) { tab in
                    Button(action: {
                        let selection = self.tabs.firstIndex(of: tab) ?? 0
                        self.selectionState = selection
                    }) {
                        HStack {
                            Spacer()
                            Text(tab).font(self.font)
                            Spacer()
                        }
                    }
                    .padding(.vertical, 16)
                        .accentColor(
                            self.isSelected(tabIdentifier: tab)
                                ? self.activeAccentColor
                                : self.inactiveAccentColor)
                        .background(
                            self.isSelected(tabIdentifier: tab)
                                ? self.activeTabColor
                                : self.inactiveTabColor)
                }
            }
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(self.selectionBarColor)
                        .frame(width: self.tabWidth(from: geometry.size.width), height: self.selectionBarHeight, alignment: .leading)
                        .offset(x: self.selectionBarXOffset(from: geometry.size.width), y: 0)
                        .animation(self.animation)
                    Rectangle()
                        .fill(self.selectionBarBackgroundColor)
                        .frame(width: geometry.size.width, height: self.selectionBarBackgroundHeight, alignment: .leading)
                }.fixedSize(horizontal: false, vertical: true)
            }.fixedSize(horizontal: false, vertical: true)
            
        }
    }
    
    // MARK: Private Helper
    
    private func isSelected(tabIdentifier: String) -> Bool {
        return tabs[selectionState] == tabIdentifier
    }
    
    private func selectionBarXOffset(from totalWidth: CGFloat) -> CGFloat {
        return self.tabWidth(from: totalWidth) * CGFloat(selectionState)
    }
    
    private func tabWidth(from totalWidth: CGFloat) -> CGFloat {
        return totalWidth / CGFloat(tabs.count)
    }
}

#if DEBUG

@available(iOS 13.0, *)
struct SlidingTabConsumerView3 : View {
    @State private var selectedTabIndex = 0
    @State var teachers: [User1] = []

    
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack{
                Image("profile")
                
                    .resizable()
                    .padding(.leading ,10)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                VStack(alignment: .leading) {
                    
                    Text("Good Morning,")
                        .font(.system(size:20))
                        .foregroundColor(Color(0xFF016DB1))
                        
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Mr. Beyram")
                        .font(.system(size:20))
                        .bold()
                        
                    .frame(maxWidth: .infinity, alignment: .leading)}
                
                
            }
            Text("Teachers List")
                .font(.system(size:20))
                .foregroundColor(.black)
                .bold()
                .padding(.leading ,15)
                .frame(maxWidth: .infinity, alignment: .leading)
            SlidingTabView(selection: self.$selectedTabIndex,
                           tabs: ["Verified", "Not Verified"],
                           font: .body,
                           activeAccentColor: Color(0xFF016DB1),
                           selectionBarColor: Color(0xFF016DB1))
            ScrollView {
                ForEach(teachers) { teacher in
                    if (selectedTabIndex == 0 && teacher.verified && teacher.userRole == "teacher")
                    {
                        ListViewCell2(name: "\(teacher.firstName) \(teacher.lastName)", email: teacher.email, number:"#\(teacher.registrationCode)", _id : teacher._id)
                       

                            
                    }else if (selectedTabIndex == 1 && !teacher.verified && teacher.userRole == "teacher"){
                        ListViewCell2(name: "\(teacher.firstName) \(teacher.lastName)", email: teacher.email, number:"#\(teacher.registrationCode)", _id : teacher._id)
                        


                    } }}.onAppear {
                        fetchData()
                    }
            Spacer()
        }
        .padding(.top, 50)
            .animation(.none)
    }
    func fetchData() {
          guard let url = URL(string: "\(Api().baseurl)/users") else { return }
          
          URLSession.shared.dataTask(with: url) { data, response, error in
              if let data = data {
                  if let decodedResponse = try? JSONDecoder().decode([User1].self, from: data) {
                      DispatchQueue.main.async {
                          self.teachers = decodedResponse
                      }
                      return
                  }
              }
              print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
          }.resume()
      }
}

@available(iOS 13.0.0, *)
struct SlidingTabView_Previews3 : PreviewProvider {
    static var previews: some View {
        SlidingTabConsumerView3()
    }
}
#endif
