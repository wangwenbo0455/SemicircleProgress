//
//  NSFileManager+FastKit.h
//  CareU
//
//  Created by 李新星 on 15/12/30.
//  Copyright © 2015年 深圳创达云睿智能科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Directory type enum
 */
typedef NS_ENUM(NSInteger, FSDirectoryType)
{
    /**
     *  Main bundle directory
     */
    FSDirectoryTypeMainBundle = 0,
    /**
     *  Library directory
     */
    FSDirectoryTypeLibrary,
    /**
     *  Documents directory
     */
    FSDirectoryTypeDocuments,
    /**
     *  Cache directory
     */
    FSDirectoryTypeCache
};

@interface NSFileManager (FastKit)

/**
 *  Read a file an return the content as NSString
 *
 *  @param file File name
 *  @param type File type
 *
 *  @return Return the content of the file a NSString
 */
+ (NSString *)readTextFile:(NSString *)file
                    ofType:(NSString *)type;

/**
 *  Save a given array into a PLIST with the given filename
 *
 *  @param path     Path of the PLIST
 *  @param filename PLIST filename
 *  @param array    Array to save into PLIST
 *
 *  @return Return YES if the operation was successful, otherwise NO
 */
+ (BOOL)saveArrayToPath:(FSDirectoryType)path
           withFilename:(NSString *)fileName
                  array:(NSArray *)array;

/**
 *  Load array from a PLIST with the given filename
 *
 *  @param path     Path of the PLIST
 *  @param fileName PLIST filename
 *
 *  @return Return the loaded array
 */
+ (NSArray *)loadArrayFromPath:(FSDirectoryType)path
                  withFilename:(NSString *)fileName;

/**
 *  Get the Bundle path for a filename
 *
 *  @param fileName Filename
 *
 *  @return Return the path as a NSString
 */
+ (NSString *)getBundlePathForFile:(NSString *)fileName;

/**
 *  Get the Documents filepath for a filename
 *
 *  @param fileName Filename
 *
 *  @return Return the filepath as a NSString
 */
+ (NSString *)getDocumentsFile:(NSString *)fileName;

/**
 *  Get the Documents directory for a filename
 *
 *  @param fileName Filename
 *
 *  @return Return the directory as a NSString
 */
+ (NSString *)getDocumentsDirectoryForFile:(NSString *)fileName;

/**
 *  Get the Library directory for a filename
 *
 *  @param fileName Filename
 *
 *  @return Return the directory as a NSString
 */
+ (NSString *)getLibraryDirectoryForFile:(NSString *)fileName;

/**
 *  Get the Cache directory for a filename
 *
 *  @param fileName Filename
 *
 *  @return Return the directory as a NSString
 */
+ (NSString *)getCacheDirectoryForFile:(NSString *)fileName;

/**
 *  Return the size of the file
 *
 *  @param fileName  Filename
 *  @param directory Directory of the file
 *
 *  @return Return the file size
 */
+ (NSNumber *)fileSize:(NSString *)fileName fromDirectory:(FSDirectoryType)directory;

/**
 *  Delete a file with the given filename.
 *
 *  @param filename Filename to delete
 *  @param origin   Directory of the file
 *
 *  @return Return YES if the operation was successful, otherwise NO
 */
+ (BOOL)deleteFile:(NSString *)fileName
     fromDirectory:(FSDirectoryType)directory;

/**
 *  Move a file from a directory to another
 *
 *  @param fileName    Filename to move
 *  @param origin      Origin directory of the file
 *  @param destination Destination directory of the file
 *
 *  @return Return YES if the operation was successful, otherwise NO
 */
+ (BOOL)moveLocalFile:(NSString *)fileName
        fromDirectory:(FSDirectoryType)origin
          toDirectory:(FSDirectoryType)destination;

/**
 *  Move a file from a directory to another
 *
 *  @param fileName    Filename to move
 *  @param origin      Origin directory of the file
 *  @param destination Destination directory of the file
 *  @param folderName  Folder name where to move the file. If folder not exist it will be created automatically
 *
 *  @return Return YES if the operation was successful, otherwise NO
 */
+ (BOOL)moveLocalFile:(NSString *)fileName
        fromDirectory:(FSDirectoryType)origin
          toDirectory:(FSDirectoryType)destination
       withFolderName:(NSString *)folderName;

/**
 *  Duplicate a file into another directory
 *
 *  @param origin      Origin path
 *  @param destination Destination path
 *
 *  @return Return YES if the operation was successful, otherwise NO
 */
+ (BOOL)duplicateFileAtPath:(NSString *)origin
                  toNewPath:(NSString *)destination;

/**
 *  Rename a file with another filename
 *
 *  @param origin  Origin path
 *  @param path    Subdirectory path
 *  @param oldName Old filename
 *  @param newName New filename
 *
 *  @return Return YES if the operation was successful, otherwise NO
 */
+ (BOOL)renameFileFromDirectory:(FSDirectoryType)origin
                         atPath:(NSString *)path
                    withOldName:(NSString *)oldName
                     andNewName:(NSString *)newName;

/**
 *  Get the App settings for a given key
 *
 *  @param objKey Key to get the object
 *
 *  @return Return the object for the given key
 */
+ (id)getAppSettingsForObjectWithKey:(NSString *)objKey;

/**
 *  Set the App settings for a given object and key. The file will be saved in the Library directory
 *
 *  @param value  Object to set
 *  @param objKey Key to set the object
 *
 *  @return Return YES if the operation was successful, otherwise NO
 */
+ (BOOL)setAppSettingsForObject:(id)value
                         forKey:(NSString *)objKey;

/**
 *  Get the given settings for a given key
 *
 *  @param settings Settings filename
 *  @param objKey   Key to set the object
 *
 *  @return Return the object for the given key
 */
+ (id)getSettings:(NSString *)settings
     objectForKey:(NSString *)objKey;

/**
 *  Set the given settings for a given object and key. The file will be saved in the Library directory
 *
 *  @param settings Settings filename
 *  @param value    Object to set
 *  @param objKey   Key to set the object
 *
 *  @return Return YES if the operation was successful, otherwise NO
 */
+ (BOOL)setSettings:(NSString *)settings
             object:(id)value forKey:(NSString *)objKey;

@end
