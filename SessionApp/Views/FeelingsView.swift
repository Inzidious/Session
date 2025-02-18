//
//  FeelingsView.swift
//  SessionApp
//
//  Created by Shawn McLean on 3/22/24.
//

import SwiftUI
import SwiftData
import CoreData

enum Option:Int
{
    case z = 0
    case a = 1
    case b = 2
    case c = 3
    case d = 4
    case e = 5
}

struct iOSCheckBoxStyle : ToggleStyle
{
    func makeBody(configuration: Configuration) -> some View
    {
        Button
        {
            configuration.isOn.toggle()
        }
    label:
        {
            VStack
            {
                Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                    .resizable().frame(width:20, height:20)
                configuration.label
            }
        }
    }
}

struct SleepRow: View
{
    @State private var selected = 1
    @State var selectedOption: Option? = nil
    var bullshizz:Int = 4
    @Bindable var feeling:FeelingEntry
    
    var body: some View
    {
        HStack
        {
            RadioButton(tag: .a, selection: $selectedOption, label: "Great")
            Spacer().frame(width: 30)
            RadioButton(tag: .b, selection: $selectedOption, label: "Good")
            Spacer().frame(width: 30)
            RadioButton(tag: .c, selection: $selectedOption, label: "Low")
            Spacer().frame(width: 30)
            RadioButton(tag: .d, selection: $selectedOption, label: "None")
            Spacer().frame(width: 90)
            
        }.onChange(of: selectedOption)
        {   oldValue, newValue in
            
            if( newValue == .a)
            {
                feeling.sleep = 1
            }
            else if( newValue == .b)
            {
                feeling.sleep = 2
            }
            else if( newValue == .c)
            {
                feeling.sleep = 3
            }
            else if( newValue == .d)
            {
                feeling.sleep = 4
            }
            else if( newValue == nil)
            {
                feeling.sleep = 0
            }
            
        }.onAppear()
        {
            if( feeling.sleep == 1 )
            {
                selectedOption = .a
            }
            else if( feeling.sleep == 2 )
            {
                selectedOption = .b
            }
            if( feeling.sleep == 3 )
            {
                selectedOption = .c
            }
            if( feeling.sleep == 4 )
            {
                selectedOption = .d
            }
        }
    }
}

struct FoodRow: View
{
    @State private var selected = 1
    @State var selectedOption: Option? = nil
    @Bindable var feeling:FeelingEntry
    
    var body: some View
    {
        HStack
        {
            RadioButton(tag: .a, selection: $selectedOption, label: "Great")
            Spacer().frame(width: 30)
            RadioButton(tag: .b, selection: $selectedOption, label: "Good")
            Spacer().frame(width: 30)
            RadioButton(tag: .c, selection: $selectedOption, label: "Low")
            Spacer().frame(width: 30)
            RadioButton(tag: .d, selection: $selectedOption, label: "None")
            Spacer().frame(width: 90)
            
        }.onChange(of: selectedOption)
        {   oldValue, newValue in
            
            if( newValue == .a)
            {
                feeling.food = 1
            }
            else if( newValue == .b)
            {
                feeling.food = 2
            }
            else if( newValue == .c)
            {
                feeling.food = 3
            }
            else if( newValue == .d)
            {
                feeling.food = 4
            }
            else if( newValue == nil)
            {
                feeling.food = 0
            }
            
        }.onAppear()
        {
            if( feeling.food == 1 )
            {
                selectedOption = .a
            }
            else if( feeling.food == 2 )
            {
                selectedOption = .b
            }
            if( feeling.food == 3 )
            {
                selectedOption = .c
            }
            if( feeling.food == 4 )
            {
                selectedOption = .d
            }
        }
    }
}

struct MovementRow: View
{
    @State private var selected = 1
    @State var selectedOption: Option? = nil
    @Bindable var feeling:FeelingEntry
    
    var body: some View
    {
        HStack
        {
            RadioButton(tag: .a, selection: $selectedOption, label: "Great")
            Spacer().frame(width: 30)
            RadioButton(tag: .b, selection: $selectedOption, label: "Good")
            Spacer().frame(width: 30)
            RadioButton(tag: .c, selection: $selectedOption, label: "Low")
            Spacer().frame(width: 30)
            RadioButton(tag: .d, selection: $selectedOption, label: "None")
            Spacer().frame(width: 90)
            
        }.onChange(of: selectedOption)
        {   oldValue, newValue in
            
            if( newValue == .a)
            {
                feeling.move = 1
            }
            else if( newValue == .b)
            {
                feeling.move = 2
            }
            else if( newValue == .c)
            {
                feeling.move = 3
            }
            else if( newValue == .d)
            {
                feeling.move = 4
            }
            else if( newValue == nil)
            {
                feeling.move = 0
            }
        }.onAppear()
        {
            if( feeling.move == 1 )
            {
                selectedOption = .a
            }
            else if( feeling.move == 2 )
            {
                selectedOption = .b
            }
            if( feeling.move == 3 )
            {
                selectedOption = .c
            }
            if( feeling.move == 4 )
            {
                selectedOption = .d
            }
        }
    }
}

struct IrritRow: View
{
    @State private var selected = 1
    @State var selectedOption: Option? = nil
    var bullshizz:Int = 4
    
    var body: some View
    {
        HStack
        {
            RadioButton(tag: .a, selection: $selectedOption, label: "None")
            Spacer().frame(width: 30)
            RadioButton(tag: .b, selection: $selectedOption, label: "Low")
            Spacer().frame(width: 30)
            RadioButton(tag: .c, selection: $selectedOption, label: "Medium")
            Spacer().frame(width: 30)
            RadioButton(tag: .d, selection: $selectedOption, label: "High")
            Spacer().frame(width: 90)
            
        }.onChange(of: selectedOption){oldValue, newValue in
            
            //print("Changing from \(oldValue) to \(newValue)")
        }
    }
}

struct MenstRow: View
{
    @State private var selected = 1
    @State var selectedOption: Option? = nil
    var bullshizz:Int = 4
    
    var body: some View
    {
        HStack
        {
            RadioButton(tag: .a, selection: $selectedOption, label: "Folicular")
            Spacer().frame(width: 30)
            RadioButton(tag: .b, selection: $selectedOption, label: "Ovulation")
            Spacer().frame(width: 30)
            RadioButton(tag: .c, selection: $selectedOption, label: "Luteal")
            Spacer().frame(width: 30)
            RadioButton(tag: .d, selection: $selectedOption, label: "Menstruation")
            Spacer().frame(width: 20)
            
        }.onChange(of: selectedOption){oldValue, newValue in
            
            //print("Changing from \(oldValue) to \(newValue)")
        }
    }
}

struct MediRow: View
{
    @State private var selected = 1
    @State var selectedOption: Option? = nil
    var bullshizz:Int = 4
    
    var body: some View
    {
        HStack
        {
            RadioButton(tag: .a, selection: $selectedOption, label: "Yes")
            Spacer().frame(width: 30)
            RadioButton(tag: .b, selection: $selectedOption, label: "No")
            Spacer().frame(width: 280)
            
        }.onChange(of: selectedOption){oldValue, newValue in
            
            //print("Changing from \(oldValue) to \(newValue)")
        }
    }
}

struct CheckBox: View
{
    @State private var isToggled = false
    @Binding private var isSelected: Bool
    
    var txt:String
    
    var body: some View
    {
        Toggle(isOn: $isToggled)
        {
            Text(txt)
        }
        .toggleStyle(iOSCheckBoxStyle())
        .onTapGesture {
            isSelected = true;
        }
    }
}

struct TitleBoxSelect: View
{
    @State private var selected:Int = 0;
    
    var body: some View
    {
        ZStack
        {
            Rectangle()
                .frame(width:370, height:220)
                .foregroundColor(Color(.white).opacity(0))
                .border(Color.black)
            
            VStack
            {
                Text("How are you feeling?")
                    .foregroundColor(.black)
                    .font(.openSansRegular(size: 35))
                    .padding(10)
                
                ImageRowPicker()
            }
            
        }.frame(maxWidth:.infinity, alignment: .center)
    }
}

struct ButtonBlock: View
{
    @State var selected:Int;
    var itemNumber:Int;
    var imgName:String;
    var txtName:String;
    
    var body: some View
    {
        Button()
        {
            if(selected != itemNumber)
            {
                selected = itemNumber;
            }
            else
            {
                selected = 0;
            }
        }
    label:
        {
            VStack
            {
                if(selected == itemNumber)
                {
                    Image(imgName).resizable().frame(width:100, height:100)
                }
                else
                {
                    Image(imgName)
                }
                
                Text(txtName)
                    .foregroundColor(.black)
                    .font(Font.custom("Papyrus", size:18))
                    .padding(1)
            }
        }
    }
}

struct ImageRowSelected: View
{
    @State var selected:Int;
    
    var body: some View
    {
        HStack
        {
            ButtonBlock(selected:selected,
                        itemNumber:1,
                        imgName:"stellar",
                        txtName:"Stellar")
            
            ButtonBlock(selected:selected,
                        itemNumber:2,
                        imgName:"great",
                        txtName:"Great")
            
            ButtonBlock(selected:selected,
                        itemNumber:3,
                        imgName:"fair",
                        txtName:"Fair")
            
            ButtonBlock(selected:selected,
                        itemNumber:4,
                        imgName:"bad",
                        txtName:"Bad")
            
            ButtonBlock(selected:selected,
                        itemNumber:5,
                        imgName:"abysmal",
                        txtName:"Abysmal")
        }
    }
}

struct FeelingRow: View
{
    var rowTitle: String
    @State var isShowingFeelingsheet: Bool = false
    
    var body: some View
    {
        HStack
        {
            Text(rowTitle)
                .foregroundColor(.black)
                .font(.openSansRegular(size: 25))
                .padding(20)
            
            Spacer()
            
            Text("Enter Notes")
                .foregroundColor(.red)
                .font(.openSansRegular(size: 16))
            
            Button()
            {
                isShowingFeelingsheet = true
            }
        label:
            {
                ZStack
                {
                    Rectangle()
                        .frame(width:70, height:35)
                        .foregroundColor(Color(.gray).opacity(0.1))
                        .border(Color.black)
                        .padding(20)
                    
                    Text("...")
                        .font(.openSansRegular(size: 45))
                }
            }
        }
        .frame(width:400, height:45)
        .background(Color(.gray).opacity(0.4))
        .sheet(isPresented : $isShowingFeelingsheet)
        {
            addFeelingSheet()
        }
    }
}

struct RadioButton: View
{
    @Binding private var isSelected: Bool
    private let label: String
    
    init(isSelected: Binding<Bool>, label: String = "")
    {
        self._isSelected = isSelected
        self.label = label
    }
    
    init<V: Hashable>(tag: V, selection: Binding<V?>, label: String = "")
    {
        self._isSelected = Binding(
            get: { selection.wrappedValue == tag },
            set:
                { (check:Bool) in
                    //print("inside closure", tag, "check: ", check)
                    
                    if(!check)
                    {
                        selection.wrappedValue = nil
                    }
                    else
                    {
                        selection.wrappedValue = tag
                    }
                }
        )
        self.label = label
    }
    
    var body: some View {
        VStack(spacing: 10) {
            circleView
            labelView
        }
        .contentShape(Rectangle())
        .onTapGesture
        {
            //  If they tapped on this radiobutton, and it's
            //  already selected, unselected it
            if( isSelected )
            {
                isSelected = false
            }
            else
            {
                isSelected = true
            }
        }
    }
}

private extension RadioButton
{
    @ViewBuilder var labelView: some View
    {
        if !label.isEmpty
        { // Show label if label is not empty
            Text(label)
        }
    }
    
    @ViewBuilder var circleView: some View
    {
        Circle()
            .fill(innerCircleColor) // Inner circle color
            .padding(4)
            .overlay(
                Circle()
                    .stroke(outlineColor, lineWidth: 1)
            ) // Circle outline
            .frame(width: 20, height: 20)
    }
}

private extension RadioButton
{
    var innerCircleColor: Color
    {
        if( isSelected )
        {
            //print("setting blue")
            return Color.blue
        }
        else
        {
            //print("setting clear")
            return Color.clear
        }
        //return isSelected ? Color.blue : Color.clear
    }
    
    var outlineColor: Color {
        return isSelected ? Color.blue : Color.gray
    }
}

struct ImageRadioButton: View
{
    @Binding private var isSelected: Bool
    private let label: String
    private var imageName:String
    
    init(isSelected: Binding<Bool>, label: String = "", imageName:String = "")
    {
        self._isSelected = isSelected
        self.label = label
        self.imageName = imageName
    }
    
    init<V: Hashable>(tag: V, selection: Binding<V?>, label: String = "", imageName:String = "")
    {
        self.imageName = imageName
        self._isSelected = Binding(
            get: { selection.wrappedValue == tag },
            set:
                { (check:Bool) in
                    //print("inside closure", tag, "check: ", check)
                    
                    if(!check)
                    {
                        selection.wrappedValue = nil
                    }
                    else
                    {
                        selection.wrappedValue = tag
                    }
                }
        )
        self.label = label
    }
    
    var body: some View {
        VStack(spacing: 10) {
            imageView
            labelView
        }
        .contentShape(Rectangle())
        .onTapGesture
        {
            //  If they tapped on this radiobutton, and it's
            //  already selected, unselected it
            if( isSelected )
            {
                //print("here")
                isSelected = false
            }
            else
            {
                isSelected = true
            }
        }
    }
}

private extension ImageRadioButton
{
    @ViewBuilder var labelView: some View
    {
        if !label.isEmpty
        { // Show label if label is not empty
            Text(label).frame(width:70)
        }
    }
    
    @ViewBuilder var imageView: some View
    {
        if( isSelected )
        {
            Image(imageName).resizable().frame(width:100, height:100)
        }
        else
        {
            Image(imageName)
        }
        //imageBlock
    }
}

private extension ImageRadioButton
{
    var outlineColor: Color {
        return isSelected ? Color.blue : Color.gray
    }
}

struct ImageRowPicker: View
{
    @State private var selected = 1
    @State var selectedOption: Option? = nil
    
    @Environment(FeelingEntry.self) private var testFeeling
    
    var body: some View
    {
        HStack
        {
            ImageRadioButton(tag: .a, selection: $selectedOption, label: "Stellar", imageName:"stellar")
            Spacer().frame(width: 1)
            ImageRadioButton(tag: .b, selection: $selectedOption, label: "Great", imageName:"great")
            Spacer().frame(width: 1)
            ImageRadioButton(tag: .c, selection: $selectedOption, label: "Fair", imageName:"fair")
            Spacer().frame(width: 1)
            ImageRadioButton(tag: .d, selection: $selectedOption, label: "Bad", imageName:"bad")
            Spacer().frame(width: 1)
            ImageRadioButton(tag: .e, selection: $selectedOption, label: "Abysmal", imageName:"abysmal")
            Spacer().frame(width: 1)
            //RadioButton(tag: .b, selection: $selectedOption, label: "Ovulation")
            //Spacer().frame(width: 30)
            //RadioButton(tag: .c, selection: $selectedOption, label: "Luteal")
            //Spacer().frame(width: 30)
            //RadioButton(tag: .d, selection: $selectedOption, label: "Menstruation")
            //Spacer().frame(width: 20)
            
        }.onChange(of: selectedOption)
        {   oldValue, newValue in
            
            if( newValue == .a)
            {
                testFeeling.feeling = 1
            }
            else if( newValue == .b)
            {
                testFeeling.feeling = 2
            }
            else if( newValue == .c)
            {
                testFeeling.feeling = 3
            }
            else if( newValue == .d)
            {
                testFeeling.feeling = 4
            }
            else if( newValue == .e)
            {
                testFeeling.feeling = 5
            }
            else if( newValue == nil)
            {
                testFeeling.feeling = 0
            }
            
            //print("Changing from \(oldValue) to \(newValue)")
        }.onAppear()
        {
            if( testFeeling.feeling == 1 )
            {
                selectedOption = .a
            }
            else if( testFeeling.feeling == 2 )
            {
                selectedOption = .b
            }
            if( testFeeling.feeling == 3 )
            {
                selectedOption = .c
            }
            if( testFeeling.feeling == 4 )
            {
                selectedOption = .d
            }
            if( testFeeling.feeling == 5 )
            {
                selectedOption = .e
            }
        }
    }
}

struct addFeelingSheet : View
{
    @Environment(\.dismiss) private var dismiss
    
    @State private var entry:String = ""
    @State private var data:Date = .now
    
    var body: some View
    {
        NavigationStack
        {
            Text("Add some thoughts..")//.font(.openSansBoldItalic(size: 24))
            
            Form
            {
                TextField("Start writing....", text:$entry, axis:.vertical )
                DatePicker("Timestamp", selection:$data, displayedComponents: .date)
                
            }
            //.font(.openSansBoldItalic(size: 12))
            .toolbar
            {
                ToolbarItemGroup(placement: .topBarLeading)
                {
                    Button("Cancel"){ dismiss()}
                }
                
                ToolbarItemGroup(placement: .topBarTrailing)
                {
                    Button("Save")
                    {
                        dismiss()
                    }
                }
            }
        }.onAppear()
        {
            //print("Here")
        }
    }
}

struct FeelingsView: View
{
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) var context
    
    //@Query var feelings:[FeelingEntry]
    @State var isEditing:Bool
    
    var curFeeling:FeelingEntry
    
    init(passedFeeling:FeelingEntry? = nil)
    {
        if let feelingUnwrapped = passedFeeling
        {
            print("Existing feeling")
            curFeeling = feelingUnwrapped
            isEditing = true
        }
        else
        {
            //print("New feeling")
            curFeeling = FeelingEntry(nameTxt:"New Feeling", user:GlobalUser.shared.user)
            isEditing = false
            //context.insert(curFeeling)
        }
    }
    
    var body: some View
    {
        ZStack
        {
            Rectangle()
                .fill(Color("BGColor"))
                .ignoresSafeArea()
            
            VStack(spacing: 0)
            {
                HStack
                {
                    Button
                    {
                        dismiss()
                    }
                label:
                    {
                        Text("Cancel")
                            .font(.openSansRegular(size: 18))
                    }
                    
                    Button
                    {
                        if(!isEditing)
                        {
                            context.insert(curFeeling)
                            print("inserted!")
                            isEditing = true
                        }
                        
                        try! context.save()
                        dismiss()
                    }
                label:
                    {
                        Text("Save")
                            .font(.openSansRegular(size: 18))
                    }
                    
                    if( isEditing )
                    {
                        Button
                        {
                            context.delete(curFeeling)
                            print("deleted")
                            isEditing = false
                            try! context.save()
                            dismiss()
                        }
                    label:
                        {
                            Text("Delete")
                                .font(.openSansRegular(size: 18))
                        }
                    }
                }
                
                TitleBoxSelect()
                    .environment(curFeeling)
                    .padding(.bottom, 10)
                
                ScrollView(showsIndicators: true) {
                    VStack(spacing: 15) {
                        Group {
                            FeelingRow(rowTitle:"Sleep")
                            SleepRow(feeling:curFeeling)
                            
                            FeelingRow(rowTitle:"Food")
                            FoodRow(feeling:curFeeling)
                            
                            FeelingRow(rowTitle:"Movement")
                            MovementRow(feeling:curFeeling)
                            
                            FeelingRow(rowTitle:"Irritability")
                            IrritRow()
                            
                            FeelingRow(rowTitle:"Menstrual Cycle")
                            MenstRow()
                            
                            FeelingRow(rowTitle:"Medication")
                            MediRow()
                        }
                        .padding(.horizontal)
                        
                        Spacer(minLength: 100)
                    }
                }
                .frame(maxWidth: .infinity)
                .scrollIndicators(.visible)
            }
            .frame(maxHeight: .infinity)
        }
    }
}

#Preview {
        
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: FeelingEntry.self, configurations: config)
        return FeelingsView().modelContainer(container)
    }
