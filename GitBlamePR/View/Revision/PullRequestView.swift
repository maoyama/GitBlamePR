//
//  PullRequestView.swift
//  GitBlamePR
//
//  Created by Makoto Aoyama on 2020/04/03.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI
import Ink

struct PullRequestView: View {
    var model: PullRequestViewModel
    let mdParser = MarkdownParser(
        viewMaker: .init(image: { (str) -> AnyView in
            let urlStr = str.split(separator: " ")[0]
            return AnyView(
                    KFImage(URL(string: String(urlStr)))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                )
        }),
        viewModifier: .init(link: { (link) -> AnyView in
            let urlStr = link.url.split(separator: " ")[0]
            return AnyView(
                link.view
                    .foregroundColor(.accentColor)
                    .onTapGesture {
                        guard let url = URL(string: String(urlStr)) else { return }
                        NSWorkspace.shared.open(url)
                    }
            )
        })
    )


    var body: some View {
        VStack(alignment: .leading) {
            SectionTitleView(title: "Pull Request")
            VStack(alignment: .leading) {
                Group {
                    Text(model.title)
                            .fontWeight(.bold)
                    + Text(" " + model.number )
                    .foregroundColor(.secondary)
                }
                    .padding(.top, 4)
                if !model.body.isEmpty {
                    mdParser
                        .view(from: model.body)
                        .padding(.top, 4)
                }

                Author(
                    userAvatarURL: model.userAvatarURL,
                    user: model.user,
                    mergedAt: model.mergedAt)
                Divider()
                    .padding(.bottom, 3)
                Counter(
                    conversationCount: model.conversationCount,
                    commitsCount: model.commitsCount,
                    changedFiles: model.changedFiles,
                    additionsCount: model.additionsCount,
                    deletionsCount: model.deletionsCount
                )
                Divider()
                    .padding(.bottom, 3)
                HStack {
                    Spacer()
                    Button("Open in GitHub") {
                        NSWorkspace.shared.open(self.model.html)
                    }
                    Spacer()
                }

                HStack{
                    Spacer()
                }
                Spacer()
            }
            .padding(.init(top: 2, leading: 6, bottom: 6, trailing: 6))
        }
        .background(Color(.windowBackgroundColor))
        .padding(2)
    }
}

private struct Author: View {
    var userAvatarURL: URL
    var user: String
    var mergedAt: String

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                KFImage(userAvatarURL)
                    .cancelOnDisappear(true)
                    .resizable()
                    .renderingMode(.original)
                    .frame(width: 20, height: 20)
                    .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))
                VStack (alignment: .leading) {
                    Text(user)
                    Text(mergedAt).foregroundColor(.secondary)
                        .font(.system(size: 11))
                }.padding(.top, -2)
                Spacer()
            }
        }
    }
}

private struct Counter: View {
    var conversationCount: String
    var commitsCount: String
    var changedFiles: String
    var additionsCount: String
    var deletionsCount: String

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(conversationCount).fontWeight(.bold)
                Text("Conversation").foregroundColor(.secondary).font(.caption)
            }
            HStack {
                Text(commitsCount).fontWeight(.bold)
                Text("Commits").foregroundColor(.secondary).font(.caption)
            }
            HStack {
                Text(changedFiles).fontWeight(.bold)
                Text("File changed").foregroundColor(.secondary).font(.caption)
            }
            HStack {
                Text(additionsCount).foregroundColor(.green)
                Text(deletionsCount).foregroundColor(.red)
            }
        }
    }
}

struct PullRequestView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PullRequestView(model:
                PullRequestViewModel(
                    html: URL(string: "https://example.com")!,
                    number: "#17",
                    title: "Fix git blame pr command failure when not commited",
                    body: "GitBlamePR.app bundles Xcode Source Editor Extension.Files opened in Xcode can be easily opened in GitBlamePR.app.I recommend that you set a key binding for this function.",
                    user: "maoyama",
                    userAvatarURL: URL(string: "https://avatars1.githubusercontent.com/u/1035994?s=88&u=e0708d80549806332126ec2174ef2a4abf16fa22&v=4")!,
                    mergedAt: "8 days ago",
                    conversationCount: "10",
                    commitsCount: "7",
                    changedFiles: "8",
                    additionsCount: "+283",
                    deletionsCount: "-130"
                )
            )
                .frame(width: 200)
                .environment(\.colorScheme, .light)

            PullRequestView(model:
                PullRequestViewModel(
                    html: URL(string: "https://example.com")!,
                    number: "#17",
                    title: "Fix git blame pr command failure when not commited",
                    body: "GitBlamePR.app bundles Xcode Source Editor Extension.Files opened in Xcode can be easily opened in GitBlamePR.app.I recommend that you set a key binding for this function.",
                    user: "maoyama",
                    userAvatarURL: URL(string: "https://avatars1.githubusercontent.com/u/1035994?s=88&u=e0708d80549806332126ec2174ef2a4abf16fa22&v=4")!,
                    mergedAt: "8 days ago",
                    conversationCount: "10",
                    commitsCount: "7",
                    changedFiles: "8",
                    additionsCount: "+283",
                    deletionsCount: "-130"
                )
            ).frame(width: 200)
            .environment(\.colorScheme, .dark)

            PullRequestView(model:
                PullRequestViewModel(
                    html: URL(string: "https://example.com")!,
                    number: "#17",
                    title: "Fix git blame pr command failure when not commited",
                    body: "",
                    user: "Maoyama",
                    userAvatarURL: URL(string: "https://avatars1.githubusercontent.com/u/1035994?s=88&u=e0708d80549806332126ec2174ef2a4abf16fa22&v=4")!,
                    mergedAt: "2020/04/20",
                    conversationCount: "10",
                    commitsCount: "7",
                    changedFiles: "8",
                    additionsCount: "+283",
                    deletionsCount: "-130"
                )
            ).frame(width: 250)
            .environment(\.colorScheme, .dark)

            PullRequestView(model:
                PullRequestViewModel(
                    html: URL(string: "https://example.com")!,
                    number: "#17",
                    title: "Fix git blame pr command failure when not commited",
                    body: """
                    ---
                    __Advertisement :)__

                    - __[pica](https://nodeca.github.io/pica/demo/)__ - high quality and fast image
                      resize in browser.
                    - __[babelfish](https://github.com/nodeca/babelfish/)__ - developer friendly
                      i18n with plurals support and easy syntax.

                    You will like those projects!

                    ---

                    # h1 Heading 8-)
                    ## h2 Heading
                    ### h3 Heading
                    #### h4 Heading
                    ##### h5 Heading
                    ###### h6 Heading


                    ## Horizontal Rules

                    ___

                    ---

                    ***


                    ## Typographic replacements

                    Enable typographer option to see result.

                    (c) (C) (r) (R) (tm) (TM) (p) (P) +-

                    test.. test... test..... test?..... test!....

                    !!!!!! ???? ,,  -- ---

                    "Smartypants, double quotes" and 'single quotes'


                    ## Emphasis

                    **This is bold text**

                    __This is bold text__

                    *This is italic text*

                    _This is italic text_

                    ~~Strikethrough~~


                    ## Blockquotes


                    > Blockquotes can also be nested...
                    >> ...by using additional greater-than signs right next to each other...
                    > > > ...or with spaces between arrows.


                    ## Lists

                    Unordered

                    + Create a list by starting a line with `+`, `-`, or `*`
                    + Sub-lists are made by indenting 2 spaces:
                      - Marker character change forces new list start:
                        * Ac tristique libero volutpat at
                        + Facilisis in pretium nisl aliquet
                        - Nulla volutpat aliquam velit
                    + Very easy!

                    Ordered

                    1. Lorem ipsum dolor sit amet
                    2. Consectetur adipiscing elit
                    3. Integer molestie lorem at massa


                    1. You can use sequential numbers...
                    1. ...or keep all the numbers as `1.`

                    Start numbering with offset:

                    57. foo
                    1. bar


                    ## Code

                    Inline `code`

                    Indented code

                        // Some comments
                        line 1 of code
                        line 2 of code
                        line 3 of code


                    Block code "fences"

                    ```
                    Sample text here...
                    ```

                    Syntax highlighting

                    ``` js
                    var foo = function (bar) {
                      return bar++;
                    };

                    console.log(foo(5));
                    ```

                    ## Tables

                    | Option | Description |
                    | ------ | ----------- |
                    | data   | path to data files to supply the data that will be passed into templates. |
                    | engine | engine to be used for processing templates. Handlebars is the default. |
                    | ext    | extension to be used for dest files. |

                    Right aligned columns

                    | Option | Description |
                    | ------:| -----------:|
                    | data   | path to data files to supply the data that will be passed into templates. |
                    | engine | engine to be used for processing templates. Handlebars is the default. |
                    | ext    | extension to be used for dest files. |


                    ## Links

                    [link text](http://dev.nodeca.com)

                    [link with title](http://nodeca.github.io/pica/demo/ "title text!")

                    Autoconverted link https://github.com/nodeca/pica (enable linkify to see)


                    ## Images

                    ![Minion](https://octodex.github.com/images/minion.png)
                    ![Stormtroopocat](https://octodex.github.com/images/stormtroopocat.jpg "The Stormtroopocat")

                    Like links, Images also have a footnote style syntax

                    ![Alt text][id]

                    With a reference later in the document defining the URL location:

                    [id]: https://octodex.github.com/images/dojocat.jpg  "The Dojocat"


                    ## Plugins

                    The killer feature of `markdown-it` is very effective support of
                    [syntax plugins](https://www.npmjs.org/browse/keyword/markdown-it-plugin).


                    ### [Emojies](https://github.com/markdown-it/markdown-it-emoji)

                    > Classic markup: :wink: :crush: :cry: :tear: :laughing: :yum:
                    >
                    > Shortcuts (emoticons): :-) :-( 8-) ;)

                    see [how to change output](https://github.com/markdown-it/markdown-it-emoji#change-output) with twemoji.


                    ### [Subscript](https://github.com/markdown-it/markdown-it-sub) / [Superscript](https://github.com/markdown-it/markdown-it-sup)

                    - 19^th^
                    - H~2~O

                    ==Marked text==


                    ### [Footnotes](https://github.com/markdown-it/markdown-it-footnote)

                    Footnote 1 link[^first].

                    Footnote 2 link[^second].

                    Inline footnote^[Text of inline footnote] definition.

                    Duplicated footnote reference[^second].

                    [^first]: Footnote **can have markup**

                        and multiple paragraphs.

                    [^second]: Footnote text.


                    ### [Definition lists](https://github.com/markdown-it/markdown-it-deflist)

                    Term 1

                    :   Definition 1
                    with lazy continuation.

                    Term 2 with *inline markup*

                    :   Definition 2

                            { some code, part of Definition 2 }

                        Third paragraph of definition 2.

                    _Compact style:_

                    Term 1
                      ~ Definition 1

                    Term 2
                      ~ Definition 2a
                      ~ Definition 2b


                    ### [Abbreviations](https://github.com/markdown-it/markdown-it-abbr)

                    This is HTML abbreviation example.

                    It converts "HTML", but keep intact partial entries like "xxxHTMLyyy" and so on.

                    *[HTML]: Hyper Text Markup Language

                    ### [Custom containers](https://github.com/markdown-it/markdown-it-container)

                    ::: warning
                    *here be dragons*
                    :::
                    """,
                    user: "Maoyama",
                    userAvatarURL: URL(string: "https://avatars1.githubusercontent.com/u/1035994?s=88&u=e0708d80549806332126ec2174ef2a4abf16fa22&v=4")!,
                    mergedAt: "2020/04/20",
                    conversationCount: "10",
                    commitsCount: "7",
                    changedFiles: "8",
                    additionsCount: "+283",
                    deletionsCount: "-130"
                )
            ).frame(width: 350)
            .environment(\.colorScheme, .dark)

        }
    }
}

