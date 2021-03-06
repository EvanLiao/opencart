<?php echo $header; ?>
<div class="container">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
  <?php if ($error_warning) { ?>
  <div class="alert alert-danger"><i class="icon-exclamation-sign"></i> <?php echo $error_warning; ?>
    <button type="button" class="close" data-dismiss="alert">&times;</button>
  </div>
  <?php } ?>
  <div class="panel">
    <div class="panel-heading">
      <h1 class="panel-title"><i class="icon-edit icon-large"></i> <?php echo $heading_title; ?></h1>
      <div class="buttons">
        <button type="submit" form="form-slideshow" class="btn btn-primary"><i class="icon-ok"></i> <?php echo $button_save; ?></button>
        <a href="<?php echo $cancel; ?>" class="btn"><i class="icon-remove"></i> <?php echo $button_cancel; ?></a></div>
    </div>
    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-slideshow">
      <table id="module" class="table table-striped table-bordered table-hover">
        <thead>
          <tr>
            <td class="text-left"><?php echo $entry_banner; ?></td>
            <td class="text-left"><?php echo $entry_dimension; ?></td>
            <td class="text-left"><?php echo $entry_layout; ?></td>
            <td class="text-left"><?php echo $entry_position; ?></td>
            <td class="text-left"><?php echo $entry_status; ?></td>
            <td class="text-right"><?php echo $entry_sort_order; ?></td>
            <td></td>
          </tr>
        </thead>
        <tbody>
          <?php $module_row = 0; ?>
          <?php foreach ($modules as $module) { ?>
          <tr id="module-row<?php echo $module_row; ?>">
            <td class="text-left"><select name="slideshow_module[<?php echo $module_row; ?>][banner_id]" class="form-control">
                <?php foreach ($banners as $banner) { ?>
                <?php if ($banner['banner_id'] == $module['banner_id']) { ?>
                <option value="<?php echo $banner['banner_id']; ?>" selected="selected"><?php echo $banner['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $banner['banner_id']; ?>"><?php echo $banner['name']; ?></option>
                <?php } ?>
                <?php } ?>
              </select></td>
            <td class="text-left"><input type="text" name="slideshow_module[<?php echo $module_row; ?>][width]" value="<?php echo $module['width']; ?>" placeholder="<?php echo $entry_width; ?>" class="form-control" />
              <input type="text" name="slideshow_module[<?php echo $module_row; ?>][height]" value="<?php echo $module['height']; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
              <?php if (isset($error_dimension[$module_row])) { ?>
              <span class="text-error"><?php echo $error_dimension[$module_row]; ?></span>
              <?php } ?></td>
            <td class="text-left"><select name="slideshow_module[<?php echo $module_row; ?>][layout_id]" class="form-control">
                <?php foreach ($layouts as $layout) { ?>
                <?php if ($layout['layout_id'] == $module['layout_id']) { ?>
                <option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
                <?php } ?>
                <?php } ?>
              </select></td>
            <td class="text-left"><select name="slideshow_module[<?php echo $module_row; ?>][position]" class="form-control">
                <?php if ($module['position'] == 'content_top') { ?>
                <option value="content_top" selected="selected"><?php echo $text_content_top; ?></option>
                <?php } else { ?>
                <option value="content_top"><?php echo $text_content_top; ?></option>
                <?php } ?>
                <?php if ($module['position'] == 'content_bottom') { ?>
                <option value="content_bottom" selected="selected"><?php echo $text_content_bottom; ?></option>
                <?php } else { ?>
                <option value="content_bottom"><?php echo $text_content_bottom; ?></option>
                <?php } ?>
                <?php if ($module['position'] == 'column_left') { ?>
                <option value="column_left" selected="selected"><?php echo $text_column_left; ?></option>
                <?php } else { ?>
                <option value="column_left"><?php echo $text_column_left; ?></option>
                <?php } ?>
                <?php if ($module['position'] == 'column_right') { ?>
                <option value="column_right" selected="selected"><?php echo $text_column_right; ?></option>
                <?php } else { ?>
                <option value="column_right"><?php echo $text_column_right; ?></option>
                <?php } ?>
              </select></td>
            <td class="text-left"><select name="slideshow_module[<?php echo $module_row; ?>][status]" class="form-control">
                <?php if ($module['status']) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select></td>
            <td class="text-right"><input type="text" name="slideshow_module[<?php echo $module_row; ?>][sort_order]" value="<?php echo $module['sort_order']; ?>" placeholder="<?php echo $entry_sort_order; ?>" class="form-control" /></td>
            <td class="text-left"><button type="button" onclick="$('#module-row<?php echo $module_row; ?>').remove();" class="btn btn-danger"><i class="icon-minus-sign"></i> <?php echo $button_remove; ?></button></td>
          </tr>
          <?php $module_row++; ?>
          <?php } ?>
        </tbody>
        <tfoot>
          <tr>
            <td colspan="6"></td>
            <td class="text-left"><button type="button" onclick="addModule();" class="btn btn-primary"><i class="icon-plus-sign"></i> <?php echo $button_add_module; ?></button></td>
          </tr>
        </tfoot>
      </table>
    </form>
  </div>
</div>
<script type="text/javascript"><!--
var module_row = <?php echo $module_row; ?>;

function addModule() {	
	html  = '<tr id="module-row' + module_row + '">';
	html += '  <td class="text-left"><select name="slideshow_module[' + module_row + '][banner_id]" class="form-control">';
	<?php foreach ($banners as $banner) { ?>
	html += '    <option value="<?php echo $banner['banner_id']; ?>"><?php echo addslashes($banner['name']); ?></option>';
	<?php } ?>
	html += '  </select></td>';
	html += '  <td class="text-left"><input type="text" name="slideshow_module[' + module_row + '][width]" value="" placeholder="<?php echo $entry_width; ?>" class="form-control" /> <input type="text" name="slideshow_module[' + module_row + '][height]" value="" placeholder="<?php echo $entry_height; ?>" class="form-control" /></td>';
	html += '  <td class="text-left"><select name="slideshow_module[' + module_row + '][layout_id]" class="form-control">';
	<?php foreach ($layouts as $layout) { ?>
	html += '    <option value="<?php echo $layout['layout_id']; ?>"><?php echo addslashes($layout['name']); ?></option>';
	<?php } ?>
	html += '  </select></td>';
	html += '  <td class="text-left"><select name="slideshow_module[' + module_row + '][position]" class="form-control">';
	html += '    <option value="content_top"><?php echo $text_content_top; ?></option>';
	html += '    <option value="content_bottom"><?php echo $text_content_bottom; ?></option>';
	html += '    <option value="column_left"><?php echo $text_column_left; ?></option>';
	html += '    <option value="column_right"><?php echo $text_column_right; ?></option>';
	html += '  </select></td>';
	html += '  <td class="text-left"><select name="slideshow_module[' + module_row + '][status]" class="form-control">';
    html += '    <option value="1" selected="selected"><?php echo $text_enabled; ?></option>';
    html += '    <option value="0"><?php echo $text_disabled; ?></option>';
    html += '  </select></td>';
	html += '  <td class="text-right"><input type="text" name="slideshow_module[' + module_row + '][sort_order]" value="" placeholder="<?php echo $entry_sort_order; ?>" class="form-control" /></td>';
	html += '  <td class="text-left"><button type="button" onclick="$(\'#module-row' + module_row + '\').remove();" class="btn btn-danger"><i class="icon-minus-sign"></i> <?php echo $button_remove; ?></button></td>';
	html += '</tr>';
	
	$('#module tbody').append(html);
	
	module_row++;
}
//--></script> 
<?php echo $footer; ?>