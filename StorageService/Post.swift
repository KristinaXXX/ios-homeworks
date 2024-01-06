import Foundation
import UIKit

public struct Post {
    public let author: String
    public let description: String
    //public let image: String
    public let image: UIImage
    public let likes: Int16
    public let views: Int16
    public let id: UUID
    
    public init(author: String, description: String = "", image: UIImage = UIImage() /*String = ""*/, likes: Int16 = 0, views: Int16 = 0, id: UUID) {
        self.author = author
        self.description = description
        self.image = image
        self.likes = likes
        self.views = views
        self.id = id
    }
}

public let postData: [Post] = [
    Post(author: "Mike", description: "Ель обыкновенная (Picea abies) древнейший вечнозеленый вид семейства сосновых, стройное и красивое долгоживущее древесное растение с пирамидальной широкой кроной. В природе достигает 50 м в высоту. Ее прямой ствол может достигать 1 — 2 м в диаметре. Верхушка ели всегда острая, ветви растут горизонтально или дугообразно приподняты вверх. Кора красная или серая. Хвоя короткая, длиной 15 — 20 мм, ярко-зеленого или темно-зеленого цвета, с характерным ароматом. Хотя мы говорим о хвойных, как вечнозеленых растениях, на самом деле хвоя имеет свой срок жизни: у ели она держится на дереве максимум 6 — 12 лет.", 
        // image: "firImage",
         image: UIImage(named: "firImage")!,
         likes: 2, views: 20, id: UUID(uuidString: "E621E1F8-C36C-495A-93FC-0C247A3E6E5F")!),
    Post(author: "Садовое товарищество: главное подразделение", description: "Туя западная (Thuja occidentalis) родом это удивительное растение из восточных районов Северной Америки. В Европу она попала в 1540 – ровно через полвека после открытия Америки. А описана она была лишь спустя 2 века – в 1753 году шведским естествоиспытателем Карлом Линнеем. Имя он дал ей греческое – слово «туя» в переводе обозначает «воскурение» – при сжигании древесина этого дерева издает приятный запах. Это очень зимостойкое растение, его можно выращивать даже в условиях Севера.", 
         //image: "thujamage",
         image: UIImage(named: "thujamage")!,
         likes: 501, views: 101, id: UUID(uuidString: "E621E1F8-C36C-495A-93FC-0C247A4E6E5F")!),
    Post(author: "Jake", description: "Сосна́ обыкнове́нная (Pinus sylvestris), вид растений рода сосна семейства сосновых. Дерево, достигающее в лучших условиях произрастания высоты 30–40 м и диаметра ствола 1 м. Ствол прямой, цилиндрический, высокоочищенный от сучьев у деревьев, растущих в сомкнутых насаждениях; у свободно растущих – сбежистый и более суковатый. Крона сквозистая, у молодых деревьев конусовидная, у взрослых – широкая, округлая, с закруглённой или плоской вершиной, высокоподнятая.", 
         //image: "pineImage",
         image: UIImage(named: "pineImage")!,
         likes: 100, views: 30000, id: UUID(uuidString: "E676E1F8-C36C-495A-93FC-0C247A3E6E5F")!),
    Post(author: "Nikolos", description: "Пи́хта (лат. Abies) — род вечнозелёных лесообразующих голосеменных растений семейства Сосновые (Pinaceae). Характерная особенность пихт — шишки у них, как и у настоящих кедров, в отличие от большинства других хвойных семейства сосновых, растут вверх и распадаются ещё на деревьях, оставляя после себя лишь торчащие стержни, а хвоя плоская.", 
         //image: "nordmannFirImage",
         image: UIImage(named: "nordmannFirImage")!,
         likes: 0, views: 2, id: UUID(uuidString: "E671E1F8-C36C-495A-93FC-0C247A3E8E5F")!)
]
