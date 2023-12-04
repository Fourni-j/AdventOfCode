import UIKit

var exampleValue = """
467..114..
...*......
..35..633.
......#...
617*......
.....+.58.
..592.....
......755.
...$.*....
.664.598..
"""

var testValue = """
...*......
467..114..
"""

let numberRegex = /([\d]+)/

func computePartNumbers(input: String) -> Int {
    let rows = testValue.split(separator: "\n")
    var sumNumber = 0
    
    for (index, row) in rows.enumerated() {
        // Chercher un nombre et récup sa range start / end
        // Check si symbol
        //          - avant le start ✅
        //          - après le end ✅
        //          - sur la ligne d'avant (start - 1 -> end + 1)
        //          - sur la ligne d'après (start - 1 -> end + 1)
        // si symbol on ajoute au resultat
        
        let previousRow = rows.indices.contains(index - 1) ? rows[index - 1] : nil
        let nextRow = rows.indices.contains(index + 1) ? rows[index + 1] : nil
        
        let matches = row.matches(of: numberRegex)
        for match in matches {
            let before = row.indices.startIndex == match.range.lowerBound ? nil : row.index(before: match.range.lowerBound)
            let after = row.indices.endIndex < match.range.upperBound ? nil : match.range.upperBound
            
            if let before,
               row[before] != "." {
                print("FOUND SOMETHING BEFORE")
            }

            if let after,
               row[after] != "." {
                print("FOUND SOMETHING AFTER \(row[after])")
            }

            if let previousRow,
               let after = after ?? previousRow.indices.last {
                let before = before ?? match.range.lowerBound
                let subRow = previousRow[before..<after]
                print("PREVIOUS SUB ROW \(subRow)")
            }
            
        }
    }
    
    
    return 0
}

computePartNumbers(input: testValue)
