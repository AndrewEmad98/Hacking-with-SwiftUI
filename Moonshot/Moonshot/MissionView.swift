//
//  MissionView.swift
//  Moonshot
//
//  Created by Andrew Emad on 11/11/2024.
//

import SwiftUI

struct MissionView: View {
    private let mission: Mission
    private let crew: [CrewMember]
    private let rows: [GridItem] = [
        .init(.adaptive(minimum: 120))
    ]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal){ width,axis in
                        width * 0.6
                    }
                VStack(alignment: .leading) {
                    Rectangle()
                        .frame(height: 2)
                        .foregroundStyle(.lightBackground)
                        .padding(.vertical)
                    
                    Text("Mission Highlights")
                        .font(.title.bold())
                        .padding(.bottom,5)
                    Text(mission.description)
                    
                    Rectangle()
                        .frame(height: 2)
                        .foregroundStyle(.lightBackground)
                        .padding(.vertical)
                    
                    Text("Crew")
                        .font(.title.bold())
                        .foregroundStyle(.white)
                }.padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(crew, id: \.role){ member in
                            NavigationLink {
                                AstronautView(astronaut: member.astronut)
                            } label: {
                                Image(member.astronut.id)
                                    .resizable()
                                    .frame(width: 104, height: 72)
                                    .clipShape(.capsule(style: .circular))
                                    .overlay {
                                        Capsule(style: .circular)
                                            .strokeBorder(.white, lineWidth: 1)
                                    }
                                VStack(alignment: .leading) {
                                    Text(member.astronut.name)
                                        .foregroundStyle(.white)
                                        .font(.headline)
                                    Text(member.role)
                                        .foregroundStyle(.white.opacity(0.5))
                                }
                            }
                        }.padding(.horizontal)
                    }
                }
            }.padding(.bottom)
        }.navigationTitle(mission.displayName)
         .navigationBarTitleDisplayMode(.inline)
         .background(.darkBackground)
    }
    
    init(mission: Mission, astronuts: [String : Astronaut]) {
        self.mission = mission
        self.crew = mission.crew.map({ member in
            if let astronut = astronuts[member.name]{
                return .init(role: member.role, astronut: astronut)
            }
            fatalError("Missing \(member.name)")
        })
    }
}

struct CrewMember {
    let role: String
    let astronut: Astronaut
}

#Preview {
    let missions: [Mission] = Bundle.main.fetch(file:"missions.json")
    let astronuts: [String: Astronaut] = Bundle.main.fetch(file:"astronauts.json")
    
    return MissionView(mission: missions[0], astronuts: astronuts).preferredColorScheme(.dark)
}
