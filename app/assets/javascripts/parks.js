$(document).ready(function(){
  console.log("rarw");

  tinymce.init({
    selector: ".js-editor",
    plugins: [
        "advlist autolink lists link image charmap print preview anchor",
        "searchreplace visualblocks code fullscreen",
        "insertdatetime media table contextmenu paste"
    ],
    //menu: " ",
    toolbar: "undo redo | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image"

 });
});