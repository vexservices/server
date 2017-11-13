json.id       @picture.id
json.thumb    @picture.file.url(:thumb)
json.medium   @picture.file.url(:medium)
json.original @picture.file.url(:original)
