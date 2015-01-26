import UIKit

typealias CollectionViewCellConfigureBlock = (cell:UICollectionViewCell, item:AnyObject?) -> ()

public class CollectionViewDataSource: NSObject, UICollectionViewDataSource {
    var items:[AnyObject]
    var itemIdentifier:String
    var configureCellBlock:CollectionViewCellConfigureBlock
    
    init(
        items:[AnyObject],
        cellIdentifier: String,
        collectionView: UICollectionView,
        configureBlock: CollectionViewCellConfigureBlock) {
        self.items = items
        self.itemIdentifier = cellIdentifier
        self.configureCellBlock = configureBlock
        
        collectionView.registerNib(
            UINib(nibName: self.itemIdentifier, bundle:nil),
            forCellWithReuseIdentifier: self.itemIdentifier)
        
        super.init()
    }
    
    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    public func setItems(items:[AnyObject]) {
        self.items.removeAll()
        self.items = items
    }
    
    public func collectionView(
        collectionView: UICollectionView,
        cellForItemAtIndexPath
        indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(self.itemIdentifier, forIndexPath: indexPath) as UICollectionViewCell
        let item: AnyObject = self.itemAtIndexPath(indexPath)
        
        self.configureCellBlock(cell: cell, item: item)
        return cell
    }
    
    func itemAtIndexPath(indexPath: NSIndexPath) -> AnyObject {
        return self.items[indexPath.row]
    }
}