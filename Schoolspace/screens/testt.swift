import SwiftUI





class Api: ObservableObject{
    @Published var baseurl : String = "https://backspace-gamma.vercel.app"

}

struct MonthCalendarView: View {
    @State private var currentDate = Date()
    @State private var selectedDate: Date?
    private let calendar = Calendar.current
    @State private var selection = 0

    var body: some View {
        //SlidingTabConsumerView2
        TabView(selection: $selection) {
           AdminView()
           // eventview()
           // quizview()
                        .tabItem {
                            Image(systemName: "house")
                            Text("Home")
                        }
                        .tag(0)
                    
            SlidingTabConsumerView2()
                        .tabItem {
                            Image(systemName: "person.2.square.stack")
                            Text("Parents")
                        }
                        .tag(1)
                    
            SlidingTabConsumerView()
                        .tabItem {
                            Image(systemName: "person.3")
                            Text("Students")
                        }
                        .tag(2)
                    
            SlidingTabConsumerView3()
                        .tabItem {
                            Image(systemName: "person")
                            Text("Teachers")
                        }
                        .tag(3)
                    
            timetable_view()
                        .tabItem {
                            Image(systemName: "calendar")
                            Text("Calendar")
                        }
                        .tag(4)
                }
                .accentColor(Color(0xFF016DB1))
                .onChange(of: selection) { value in
                    switch value {
                    case 1:
                        // Show the ParentsView when "Parents" tab is selected
                        // You can replace this with your own view
                        print("Showing ParentsView")
                    case 2:
                        // Show the StudentsView when "Students" tab is selected
                        // You can replace this with your own view
                        print("Showing StudentsView")
                    case 3:
                        // Show the TeachersView when "Teachers" tab is selected
                        // You can replace this with your own view
                        print("Showing TeachersView")
                    case 4:
                        // Show the CalendarView when "Calendar" tab is selected
                        // You can replace this with your own view
                        print("Showing CalendarView")
                    default:
                        // Show the default view when the first tab or any unrecognized tab is selected
                        // You can replace this with your own view
                        print("Showing default view")
                    }
                }
        }
    }
    
  


extension Int {
    var monthName: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter.monthSymbols[self-1]
    }
}

struct MonthCalendar_Previews: PreviewProvider {
    static var previews: some View {
        MonthCalendarView()
    }
}




