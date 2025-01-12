require "rails_helper"

describe "question/_selection.html.erb" do
  let(:page) do
    build(:page,
          id: 1,
          answer_type: "selection",
          is_optional:,
          routing_conditions:,
          answer_settings: OpenStruct.new({ only_one_option:,
                                            selection_options: [OpenStruct.new({ name: "Bristol" }),
                                                                OpenStruct.new({ name: "London" }),
                                                                OpenStruct.new({ name: "Manchester" })] }))
  end

  let(:routing_conditions) { [] }

  let(:question) do
    QuestionRegister.from_page(page)
  end

  let(:step) { Step.new(question:, page:, form_id: 1, form_slug: "", next_page_slug: 2, page_slug: 1) }

  let(:form) do
    GOVUKDesignSystemFormBuilder::FormBuilder.new(:form, question,
                                                  ActionView::Base.new(ActionView::LookupContext.new(nil), {}, nil), {})
  end

  before do
    assign(:mode, Mode.new("live"))
    render partial: "question/selection", locals: { page: step, form: }
  end

  context "when the question allows multiple answers" do
    let(:only_one_option) { "false" }

    context "when the question is not optional" do
      let(:is_optional) { false }

      it "contains the question" do
        expect(rendered).to have_css("h1", text: page.question_text)
      end

      it "contains the options" do
        expect(rendered).to have_css("input[type='checkbox'] + label", text: "Bristol")
        expect(rendered).to have_css("input[type='checkbox'] + label", text: "London")
        expect(rendered).to have_css("input[type='checkbox'] + label", text: "Manchester")
      end

      it "does not contain the 'None of the above' option" do
        expect(rendered).not_to have_css("input[type='checkbox'] + label", text: "None of the above")
      end
    end

    context "when the question is optional" do
      let(:is_optional) { true }

      it "contains the question" do
        expect(rendered).to have_css("h1", text: page.question_text)
      end

      it "contains the options" do
        expect(rendered).to have_css("input[type='checkbox'] + label", text: "Bristol")
        expect(rendered).to have_css("input[type='checkbox'] + label", text: "London")
        expect(rendered).to have_css("input[type='checkbox'] + label", text: "Manchester")
      end

      it "contains the 'None of the above' option" do
        expect(rendered).to have_css("input[type='checkbox'] + label", text: "None of the above")
      end
    end
  end

  context "when the question does not allow multiple answers" do
    let(:only_one_option) { "true" }

    context "when the question is not optional" do
      let(:is_optional) { false }

      it "contains the question" do
        expect(rendered).to have_css("h1", text: page.question_text)
      end

      it "contains the options" do
        expect(rendered).to have_css("input[type='radio'] + label", text: "Bristol")
        expect(rendered).to have_css("input[type='radio'] + label", text: "London")
        expect(rendered).to have_css("input[type='radio'] + label", text: "Manchester")
      end

      it "does not contain the 'None of the above' option" do
        expect(rendered).not_to have_css("input[type='radio'] + label", text: "None of the above")
      end
    end

    context "when the question is optional" do
      let(:is_optional) { true }

      it "contains the question" do
        expect(rendered).to have_css("h1", text: page.question_text)
      end

      it "contains the options" do
        expect(rendered).to have_css("input[type='radio'] + label", text: "Bristol")
        expect(rendered).to have_css("input[type='radio'] + label", text: "London")
        expect(rendered).to have_css("input[type='radio'] + label", text: "Manchester")
      end

      it "contains the 'None of the above' option" do
        expect(rendered).to have_css("input[type='radio'] + label", text: "None of the above")
      end
    end
  end
end
