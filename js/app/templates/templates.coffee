Template = window.app.Template

# Equals to listItem = _.templates $('#folder-item').html()
Template.Folder.listItem = `function(obj){
var __t,__p='',__j=Array.prototype.join,print=function(){__p+=__j.call(arguments,'');};
with(obj||{}){
__p+='\n    <div class="btn-group">\n        <a class="btn dropdown-toggle btn-primary" data-toggle="dropdown" href="#">\n            <i class="icon-th icon-white"></i>\n        </a>\n        <ul class="dropdown-menu pull-right">\n            <li><a href="#/" class="edit-link" ><i class="icon-pencil"></i> Edit</a></li>\n            <li><a href="#form-folder-confirm-'+
((__t=( id ))==null?'':__t)+
'" class="delete-link" data-toggle="modal"><i class="icon-trash"></i> Delete</a></li>\n        </ul>\n    </div>\n    <h4><a href="#/folder/'+
((__t=( id ))==null?'':__t)+
'">'+
((__t=( title ))==null?'':_.escape(__t))+
'</a></h4>\n    <input type="text" class="input-large" value="'+
((__t=( title ))==null?'':_.escape(__t))+
'"/>\n';
}
return __p;
}`

# Equals to formConfirm = _.templates $('#form-folder-confirm').html()
Template.Folder.formConfirm = `function(obj){
var __t,__p='',__j=Array.prototype.join,print=function(){__p+=__j.call(arguments,'');};
with(obj||{}){
__p+='\n    <div id="form-folder-confirm-'+
((__t=( id ))==null?'':__t)+
'" class="modal hide fade form-folder-confirm" tabindex="-1" role="dialog" aria-labelledby="confirmLabel'+
((__t=( id ))==null?'':__t)+
'" aria-hidden="true">\n        <div class="modal-header">\n            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>\n            <h3 id="myModalLabel'+
((__t=( id ))==null?'':__t)+
'">'+
((__t=( title ))==null?'':__t)+
'</h3>\n        </div>\n        <div class="modal-body">\n            <p>Are you sure you want to delete this folder with all notes?</p>\n        </div>\n        <div class="modal-footer">\n            <button class="btn" data-dismiss="modal" aria-hidden="true">Cancel</button>\n                <button class="btn btn-danger delete" data-dismiss="modal">Delete</button>\n        </div>\n    </div>\n';
}
return __p;
}`

# Equals to noteItem = _.templates $('#note-item').html()
Template.Note.noteItem = `function(obj){
var __t,__p='',__j=Array.prototype.join,print=function(){__p+=__j.call(arguments,'');};
with(obj||{}){
__p+='\n    <div class="actions">\n        <a href="#form-add-note" data-toggle="modal" class="btn btn-info edit" data-action="edit">\n            <i class="icon-pencil icon-white"></i>\n        </a>\n        <a href="#form-note-confirm" data-toggle="modal" class="btn btn-danger" data-action="delete">\n            <i class="icon-trash icon-white"></i>\n        </a>\n    </div>\n    <h4><a href="#/note/'+
((__t=( id ))==null?'':__t)+
'">'+
((__t=( title ))==null?'':_.escape(__t))+
'</a></h4>\n';
}
return __p;
}`

Template.Note.noteForm = `function(obj){
var __t,__p='',__j=Array.prototype.join,print=function(){__p+=__j.call(arguments,'');};
with(obj||{}){
__p+='\n    <div class="modal-header">\n        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>\n        <h3 id="addNoteLabel">'+
((__t=( title ? "Edit note" : "New note" ))==null?'':__t)+
'</h3>\n    </div>\n    <div class="modal-body">\n        <p>\n            <label for="new-note-folder">Choose folder</label>\n            <select name="folder" id="new-note-folder" class="span3">\n            ';
 _.each(folders, function(folder, index) {
__p+='\n                <option value="'+
((__t=( folder.id ))==null?'':__t)+
'">'+
((__t=( folder.title ))==null?'':__t)+
'</option>\n                '+
((__t=( index ))==null?'':__t)+
'\n            ';
 });
__p+='\n            </select>\n        </p>\n        <p><input type="text" name="title" id="new-note-title" class="input-xlarge" placeholder="Type the title..." value="'+
((__t=( title ))==null?'':__t)+
'" /></p>\n        <p><textarea name="body" id="new-note-body" class="input-xlarge" cols="30" rows="10" placeholder="Type the body...">'+
((__t=( body ))==null?'':__t)+
'</textarea></p>\n    </div>\n    <div class="modal-footer">\n        <button class="btn btn-primary add-note">Save</button>\n        <button class="btn" data-dismiss="modal" aria-hidden="true">Cancel</button>\n    </div>\n';
}
return __p;
}`