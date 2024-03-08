import SwiftUI

struct ContentView: View {
    // State variable to hold the user-entered task
    @State private var newTask = ""
    
    // State variable to store the list of tasks
    @State private var tasks = [String]()
    
    // State variable to show or hide the alert for an empty task
    @State private var showAlert = false
    
    // State variable to track whether text field is empty
    private var isTextFieldEmpty: Bool {
        newTask.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Title
            Text("To-Do List")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            // Display the number of tasks in the list
            Text("Number of tasks: \(tasks.count)")
                .foregroundColor(.secondary)
            
            // Text field to enter new tasks
            TextField("Add a new task", text: $newTask)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            // HStack for the two buttons centered from left to right
            HStack {
                // Spacer to push the buttons to the left
                Spacer()
                
                // Button to add tasks to the list
                Button(action: {
                    if !isTextFieldEmpty {
                        tasks.append(newTask)
                        newTask = ""
                    } else {
                        showAlert = true
                    }
                }) {
                    Text("Add Task")
                        .padding()
                        .foregroundColor(.white)
                        .background(isTextFieldEmpty ? Color.gray : Color.blue)
                        .cornerRadius(8)
                }
                .disabled(isTextFieldEmpty)
                
                // Button to delete all tasks
                Button(action: {
                    tasks.removeAll()
                }) {
                    Text("Remove All Tasks")
                        .padding()
                        .foregroundColor(.white)
                        .background(tasks.isEmpty ? Color.gray : Color.blue)
                        .cornerRadius(8)
                }
                .disabled(tasks.isEmpty)
                
                // Spacer to push the buttons to the right
                Spacer()
            }
            .padding(.horizontal) // Add horizontal padding to the HStack
            
            // List of tasks
            List {
                ForEach(tasks, id: \.self) { task in
                    Text(task)
                        .foregroundColor(.primary)
                }
                .onDelete(perform: deleteTask)
            }
        }
        .padding()
    }
    
    // Function to delete a single task
    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
}

// Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
