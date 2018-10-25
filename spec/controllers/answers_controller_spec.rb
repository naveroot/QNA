# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }
  let(:answer) { question.answers.new(body: "Answer's body") }

  describe 'GET #index' do
    let(:answers) { question.answers.create(body: "Answer's body") }
    before { get :index, params: { question_id: question } }

    it 'populates an array of all answers' do
      expect(assigns(:answers)).to match_array(answers)
    end

    it 'render index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    let!(:answer) { question.answers.create(body: "Answer Title") }
    before {get :show, params: {id: answer}}
    it 'assigns the requested anwer to @answer' do
      expect(assigns(:answer)).to eq answer
    end
    it 'render template "show"' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    before { get :new, params: { question_id: question } }

    it 'assigns a new Answer to @answer' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end
    it 'render new template' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    let(:answer) { question.answers.new(body: "Answer's body") }
    context 'with valid attributes' do
      it 'saves new Answer to database' do
        expect do
          post :create, params: { question_id: question,
                                  answer: attributes_for(:answer) }
        end.to change(question.answers, :count).by(1)
      end

      it 'redirect show template' do
        post :create, params: { question_id: question, answer: attributes_for(:answer) }
        expect(response).to redirect_to answer_path(assigns(:answer))
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new Answer to database' do
        expect { post :create, params: { question_id: question, answer: attributes_for(:invalid_answer) } }.to_not change(Answer, :count)
      end

      it 'render "new" template' do
        post :create, params: { question_id: question, answer: attributes_for(:invalid_answer) }
        expect(response).to render_template :new
      end
    end

    describe 'DELETE #destroy' do
      let!(:answer) { question.answers.create(body: "Answer Title") }

      it 'deletes answer' do
        expect { delete :destroy, params: { id: answer } }.to change(question.answers, :count).by(-1)
      end

      it 'redirect to index view' do
        delete :destroy, params: { id: answer }
        expect(response).to redirect_to question_path(answer.question)
      end
    end
  end
end
