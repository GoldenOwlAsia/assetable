bind_galleries = ->

  # Bind the koh uploader and galleries to a page
  $(".gallery-uploader").each ->
    # Check that it's not already bound
    unless $(this).hasClass("uploadable")
      $(this).addClass "uploadable"
      $this = $(this)
      $this.removeClass "uploader"

      $this.assetable_uploader
        multi_selection: true
        gallery: true
        url: "/assetable/assets.js"
        max_file_size: $this.parents('.gallery').attr("data-max-file-size")
        authenticity_token: $("meta[name=\"csrf-token\"]").attr("content")
        fileRemoved: (item, button) ->
          $(button).parentsUntil('.uploader-preview').parent().find('.assetable-gallery-item-remove').val('1')
          $(button).parentsUntil('.uploader-preview').parent().fadeOut()
        error: (up, err) ->
          event = jQuery.Event('error.gallery-uploader')
          $this.trigger(event, [up, err])
          if !event.isPropagationStopped()
            alert(err.message)

        # Make the gallery sortable
        $(this).sortable
          items: "div.uploader-preview"
          distance: 50
          tolerance: 'pointer'
          placeholder: 'uploader-sortable-placeholder'
          update: (event, ui) ->
            $gallery = $(this)

            $('input.assetable-gallery-item-sort-order', $gallery).each (index) ->
              $(this).val(index)


if !window.Assetable.bind_galleries
  window.Assetable.bind_galleries = bind_galleries


$(document).ready ->

  window.Assetable.bind_galleries()

