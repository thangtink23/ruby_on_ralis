const Review = {};

Review.init = function () {
    this.initEditor();
    this.bindUIAction();
};

Review.initEditor = function () {
    this.editor_title = new MediumEditor('#review-editable-title', {
        placeholder: {
            text: $('#review-editable-title').attr('title'),
            hideOnClick: true,
        },
        autoLink: true,
        keyboardCommands: {
            /* This example includes the default options for keyboardCommands,
             if nothing is passed this is what it used */
            commands: [
                {
                    command: 'bold',
                    key: 'B',
                    meta: true,
                    shift: false,
                    alt: false,
                },
                {
                    command: 'italic',
                    key: 'I',
                    meta: true,
                    shift: false,
                    alt: false,
                },
                {
                    command: 'underline',
                    key: 'U',
                    meta: true,
                    shift: false,
                    alt: false,
                },
            ],
        },
    });
    this.editor_content = new MediumEditor('#review-editable-content', {
        placeholder: {
            text: $('#review-editable-content').attr('title'),
            hideOnClick: true,
        },
        autoLink: true,
        keyboardCommands: {
            /* This example includes the default options for keyboardCommands,
             if nothing is passed this is what it used */
            commands: [
                {
                    command: 'bold',
                    key: 'B',
                    meta: true,
                    shift: false,
                    alt: false,
                },
                {
                    command: 'italic',
                    key: 'I',
                    meta: true,
                    shift: false,
                    alt: false,
                },
                {
                    command: 'underline',
                    key: 'U',
                    meta: true,
                    shift: false,
                    alt: false,
                },
            ],
        },
    });

    $('#review-editable-content').mediumInsert({
        editor: this.editor_content,
        addons: {
            images: {
                fileUploadOptions: {
                    url: '/uploads',
                },
            },
        },
    });
};

Review.bindUIAction = function () {
    $('form').on('submit', function (e) {
        let title = Object.values(Review.editor_title.serialize())[0].value;
        let content = Object.values(Review.editor_content.serialize())[0].value;
        $('#review-editable-title').html(title);
        $('#review-editable-content').html(content);
        let img = extractImg(content);
        if (img !== null) {
            $('input[name="review[image]"]').val(img);
        }
    });
};

function extractImg(text) {
    let arr = text.split('<img');
    if (arr.length === 1) return null;
    let tmp = arr[1];
    let pos1 = tmp.indexOf('"');
    let pos2 = tmp.indexOf('"', pos1 + 1);

    let img = tmp.slice(pos1 + 1, pos2);
    pos1 = img.indexOf('uploads');
    if (pos1 >= 0) {
        img = img.slice(pos1 -1);
    }
    return img;
}
