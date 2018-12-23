// Generated using the ObjectBox Swift Generator — https://objectbox.io
// DO NOT EDIT

// swiftlint:disable all
import ObjectBox

// MARK: - Entity metadata


extension CharacterModel: __EntityRelatable {
    typealias EntityType = CharacterModel

    var _id: Id<CharacterModel> {
        return self.charID
    }
}

extension CharacterModel: EntityInspectable {
    /// Generated metadata used by ObjectBox to persist the entity.
    static var entityInfo: EntityInfo {
        return EntityInfo(
            name: "CharacterModel",
            cursorClass: CharacterModelCursor.self)
    }

    fileprivate static func buildEntity(modelBuilder: ModelBuilder) {
        let entityBuilder = modelBuilder.entityBuilder(for: entityInfo, id: 1, uid: 5905092803156374016)
        entityBuilder.addProperty(name: "charID", type: Id<CharacterModel>.entityPropertyType, flags: [.id], id: 1, uid: 9134226283351851520)
        entityBuilder.addProperty(name: "lastModified", type: Int.entityPropertyType, id: 2, uid: 5152638289463886080)
        entityBuilder.addProperty(name: "charName", type: String.entityPropertyType, id: 3, uid: 3289053187525970688)
        entityBuilder.addProperty(name: "charRealm", type: String.entityPropertyType, id: 4, uid: 5648907594982223104)
        entityBuilder.addProperty(name: "charClass", type: Int.entityPropertyType, id: 5, uid: 6517561911256570112)
        entityBuilder.addProperty(name: "thumbnail", type: String.entityPropertyType, id: 6, uid: 4488853940917986816)
        entityBuilder.addProperty(name: "averageItemLevelEquipped", type: Int.entityPropertyType, id: 7, uid: 8299555330624907008)
        entityBuilder.addProperty(name: "neckLevel", type: Int.entityPropertyType, id: 8, uid: 2845837873127346176)
        entityBuilder.addProperty(name: "spec", type: String.entityPropertyType, id: 9, uid: 2270644472030007040)
        entityBuilder.addProperty(name: "role", type: String.entityPropertyType, id: 10, uid: 8826691302563832832)
        entityBuilder.addProperty(name: "emptySockets", type: Int.entityPropertyType, id: 11, uid: 9113308859289085184)
        entityBuilder.addProperty(name: "numberOfEnchants", type: Int.entityPropertyType, id: 12, uid: 6808239956283755520)
        entityBuilder.addProperty(name: "numberOfGems", type: Int.entityPropertyType, id: 13, uid: 8130444594972320512)
        entityBuilder.addProperty(name: "totalNumberOfEnchants", type: Int.entityPropertyType, id: 14, uid: 6027126920822183424)

    }
}

extension CharacterModel {
    /// Generated entity property information.
    ///
    /// You may want to use this in queries to specify fetch conditions, for example:
    ///
    ///     box.query { CharacterModel.charID == myId }
    static var charID: Property<CharacterModel, Id<CharacterModel>> { return Property<CharacterModel, Id<CharacterModel>>(propertyId: 9134226283351851520, isPrimaryKey: true) }
    /// Generated entity property information.
    ///
    /// You may want to use this in queries to specify fetch conditions, for example:
    ///
    ///     box.query { CharacterModel.lastModified > 1234 }
    static var lastModified: Property<CharacterModel, Int> { return Property<CharacterModel, Int>(propertyId: 5152638289463886080, isPrimaryKey: false) }
    /// Generated entity property information.
    ///
    /// You may want to use this in queries to specify fetch conditions, for example:
    ///
    ///     box.query { CharacterModel.charName.startsWith("X") }
    static var charName: Property<CharacterModel, String> { return Property<CharacterModel, String>(propertyId: 3289053187525970688, isPrimaryKey: false) }
    /// Generated entity property information.
    ///
    /// You may want to use this in queries to specify fetch conditions, for example:
    ///
    ///     box.query { CharacterModel.charRealm.startsWith("X") }
    static var charRealm: Property<CharacterModel, String> { return Property<CharacterModel, String>(propertyId: 5648907594982223104, isPrimaryKey: false) }
    /// Generated entity property information.
    ///
    /// You may want to use this in queries to specify fetch conditions, for example:
    ///
    ///     box.query { CharacterModel.charClass > 1234 }
    static var charClass: Property<CharacterModel, Int> { return Property<CharacterModel, Int>(propertyId: 6517561911256570112, isPrimaryKey: false) }
    /// Generated entity property information.
    ///
    /// You may want to use this in queries to specify fetch conditions, for example:
    ///
    ///     box.query { CharacterModel.thumbnail.startsWith("X") }
    static var thumbnail: Property<CharacterModel, String> { return Property<CharacterModel, String>(propertyId: 4488853940917986816, isPrimaryKey: false) }
    /// Generated entity property information.
    ///
    /// You may want to use this in queries to specify fetch conditions, for example:
    ///
    ///     box.query { CharacterModel.averageItemLevelEquipped > 1234 }
    static var averageItemLevelEquipped: Property<CharacterModel, Int> { return Property<CharacterModel, Int>(propertyId: 8299555330624907008, isPrimaryKey: false) }
    /// Generated entity property information.
    ///
    /// You may want to use this in queries to specify fetch conditions, for example:
    ///
    ///     box.query { CharacterModel.neckLevel > 1234 }
    static var neckLevel: Property<CharacterModel, Int> { return Property<CharacterModel, Int>(propertyId: 2845837873127346176, isPrimaryKey: false) }
    /// Generated entity property information.
    ///
    /// You may want to use this in queries to specify fetch conditions, for example:
    ///
    ///     box.query { CharacterModel.spec.startsWith("X") }
    static var spec: Property<CharacterModel, String> { return Property<CharacterModel, String>(propertyId: 2270644472030007040, isPrimaryKey: false) }
    /// Generated entity property information.
    ///
    /// You may want to use this in queries to specify fetch conditions, for example:
    ///
    ///     box.query { CharacterModel.role.startsWith("X") }
    static var role: Property<CharacterModel, String> { return Property<CharacterModel, String>(propertyId: 8826691302563832832, isPrimaryKey: false) }
    /// Generated entity property information.
    ///
    /// You may want to use this in queries to specify fetch conditions, for example:
    ///
    ///     box.query { CharacterModel.emptySockets > 1234 }
    static var emptySockets: Property<CharacterModel, Int> { return Property<CharacterModel, Int>(propertyId: 9113308859289085184, isPrimaryKey: false) }
    /// Generated entity property information.
    ///
    /// You may want to use this in queries to specify fetch conditions, for example:
    ///
    ///     box.query { CharacterModel.numberOfEnchants > 1234 }
    static var numberOfEnchants: Property<CharacterModel, Int> { return Property<CharacterModel, Int>(propertyId: 6808239956283755520, isPrimaryKey: false) }
    /// Generated entity property information.
    ///
    /// You may want to use this in queries to specify fetch conditions, for example:
    ///
    ///     box.query { CharacterModel.numberOfGems > 1234 }
    static var numberOfGems: Property<CharacterModel, Int> { return Property<CharacterModel, Int>(propertyId: 8130444594972320512, isPrimaryKey: false) }
    /// Generated entity property information.
    ///
    /// You may want to use this in queries to specify fetch conditions, for example:
    ///
    ///     box.query { CharacterModel.totalNumberOfEnchants > 1234 }
    static var totalNumberOfEnchants: Property<CharacterModel, Int> { return Property<CharacterModel, Int>(propertyId: 6027126920822183424, isPrimaryKey: false) }

    fileprivate  func __setId(identifier: EntityId) {
        self.charID = Id(identifier)
    }
}

/// Generated service type to handle persisting and reading entity data. Exposed through `CharacterModel.entityInfo`.
class CharacterModelCursor: NSObject, CursorBase {
    func setEntityId(of entity: Any, to entityId: EntityId) {
        let entity = entity as! CharacterModel
        entity.__setId(identifier: entityId)
    }

    func entityId(of entity: Any) -> EntityId {
        let entity = entity as! CharacterModel
        return entity.charID.value
    }

    func collect(fromEntity entity: Any, propertyCollector: PropertyCollector, store: Store) -> ObjectBox.EntityId {
        let entity = entity as! CharacterModel

        var offsets: [(offset: OBXDataOffset, index: UInt16)] = []
        offsets.append((propertyCollector.prepare(string: entity.charName, at: 2 + 2 * 3), 2 + 2 * 3))
        offsets.append((propertyCollector.prepare(string: entity.charRealm, at: 2 + 2 * 4), 2 + 2 * 4))
        offsets.append((propertyCollector.prepare(string: entity.thumbnail, at: 2 + 2 * 6), 2 + 2 * 6))
        offsets.append((propertyCollector.prepare(string: entity.spec, at: 2 + 2 * 9), 2 + 2 * 9))
        offsets.append((propertyCollector.prepare(string: entity.role, at: 2 + 2 * 10), 2 + 2 * 10))

        propertyCollector.collect(entity.lastModified, at: 2 + 2 * 2)
        propertyCollector.collect(entity.charClass, at: 2 + 2 * 5)
        propertyCollector.collect(entity.averageItemLevelEquipped, at: 2 + 2 * 7)
        propertyCollector.collect(entity.neckLevel, at: 2 + 2 * 8)
        propertyCollector.collect(entity.emptySockets, at: 2 + 2 * 11)
        propertyCollector.collect(entity.numberOfEnchants, at: 2 + 2 * 12)
        propertyCollector.collect(entity.numberOfGems, at: 2 + 2 * 13)
        propertyCollector.collect(entity.totalNumberOfEnchants, at: 2 + 2 * 14)


        for value in offsets {
            propertyCollector.collect(dataOffset: value.offset, at: value.index)
        }

        return entity.charID.value
    }

    func createEntity(entityReader: EntityReader, store: Store) -> Any {
        let entity = CharacterModel()

        entity.charID = entityReader.read(at: 2 + 2 * 1)
        entity.lastModified = entityReader.read(at: 2 + 2 * 2)
        entity.charName = entityReader.read(at: 2 + 2 * 3)
        entity.charRealm = entityReader.read(at: 2 + 2 * 4)
        entity.charClass = entityReader.read(at: 2 + 2 * 5)
        entity.thumbnail = entityReader.read(at: 2 + 2 * 6)
        entity.averageItemLevelEquipped = entityReader.read(at: 2 + 2 * 7)
        entity.neckLevel = entityReader.read(at: 2 + 2 * 8)
        entity.spec = entityReader.read(at: 2 + 2 * 9)
        entity.role = entityReader.read(at: 2 + 2 * 10)
        entity.emptySockets = entityReader.read(at: 2 + 2 * 11)
        entity.numberOfEnchants = entityReader.read(at: 2 + 2 * 12)
        entity.numberOfGems = entityReader.read(at: 2 + 2 * 13)
        entity.totalNumberOfEnchants = entityReader.read(at: 2 + 2 * 14)



        return entity
    }
}


fileprivate func modelBytes() -> Data {
    let modelBuilder = ModelBuilder()
    CharacterModel.buildEntity(modelBuilder: modelBuilder)
    return modelBuilder.finish()
}

extension ObjectBox.Store {
    /// A store with a fully configured model. Created by the code generator with your model's metadata in place.
    ///
    /// - Parameters:
    ///   - directoryPath: Directory path to store database files in.
    ///   - maxDbSizeInKByte: Limit of on-disk space for the database files. Default is `1024 * 1024` (1 GiB).
    ///   - fileMode: UNIX-style bit mask used for the database files; default is `0o755`.
    ///   - maxReaders: Maximum amount of concurrent readers, tailored to your use case. Default is `0` (unlimited).
    convenience init(directoryPath: String, maxDbSizeInKByte: UInt64 = 1024 * 1024, fileMode: UInt32 = 0o755, maxReaders: UInt32 = 0) throws {
        try self.init(
            modelBytes: modelBytes(),
            directory: directoryPath,
            maxDbSizeInKByte: maxDbSizeInKByte,
            fileMode: fileMode,
            maxReaders: maxReaders)
        registerAllEntities()
    }
    func registerAllEntities() {
        self.register(entity: CharacterModel.self)
    }
}

// swiftlint:enable all
